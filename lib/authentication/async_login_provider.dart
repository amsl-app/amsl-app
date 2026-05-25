import 'dart:async';

import 'package:amsl_app/authentication/auth.dart';
import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/flavors.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_login_provider.g.dart';

sealed class LoginState {}

class Authenticated extends LoginState {
  final AuthController auth;

  Authenticated({required this.auth});
}

class Unauthenticated extends LoginState {}

@Riverpod(keepAlive: true, dependencies: [storages])
class AsyncLoginNotifier extends _$AsyncLoginNotifier {
  static final log = Logger("AuthPodProvider");
  static final _appAuth = FlutterAppAuth();
  CancelableOperation<AuthController>? _login;
  CancelableOperation<bool>? _logout;

  @override
  Future<LoginState> build() async {
    final secureStorage = ref.watch(storagesProvider).secure;
    return await loadState(secureStorage);
  }

  static Future<LoginState> loadState(
    FlutterSecureStorage secureStorage,
  ) async {
    log.info("loading token");
    final idToken = await secureStorage.read(key: StorageKey.idToken.key);
    final refreshToken = await secureStorage.read(
      key: StorageKey.refreshToken.key,
    );
    final accessToken = await secureStorage.read(
      key: StorageKey.accessToken.key,
    );
    final expiresAt = await secureStorage.read(
      key: StorageKey.accessTokenExpiresAt.key,
    );

    if (idToken == null ||
        refreshToken == null ||
        expiresAt == null ||
        accessToken == null) {
      return Unauthenticated();
    }

    DateTime? expiresAtDatetime = DateTime.tryParse(expiresAt);

    if (expiresAtDatetime == null) {
      log.warning("failed to decode expires at");
      expiresAtDatetime = DateTime.now();
    }

    final auth = AuthController(
      idToken: idToken,
      expiresAt: expiresAtDatetime,
      accessToken: accessToken,
      refreshToken: refreshToken,
      storage: secureStorage,
      appAuth: _appAuth,
    );

    log.info("login data loaded successfully");
    return Authenticated(auth: auth);
  }

  /// The actual login code
  /// This will be deduplicated in login()
  Future<AuthController> _doLogin() async {
    final AuthController auth;
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          F.authClientId,
          ApiConstants.redirectUrl,
          issuer: F.authUrl,
          // Uncomment to get rid of prompt before login - breaks Single Sign on
          // preferEphemeralSession: true,
          scopes: ApiConstants.scopes,
          externalUserAgent:
              ExternalUserAgent.ephemeralAsWebAuthenticationSession,
        ),
      );
      auth = await build_auth_controller(result);
    } on Exception catch (e) {
      log.warning("authentication failed", e);
      throw const AuthenticationException("Anmeldung fehlgeschlagen");
    }
    state = AsyncValue.data(Authenticated(auth: auth));
    return auth;
  }

  Future<AuthController> build_auth_controller(
    AuthorizationTokenResponse result,
  ) async {
    final String? idToken = result.idToken;
    if (idToken == null) {
      log.warning("id token not set");
      throw const AuthenticationException("Anmeldung fehlgeschlagen");
    }

    final String? refreshToken = result.refreshToken;
    if (refreshToken == null) {
      log.warning("refresh token not set");
      throw const AuthenticationException("Anmeldung fehlgeschlagen");
    }

    final String? accessToken = result.accessToken;
    if (accessToken == null) {
      log.warning("access token not set");
      throw const AuthenticationException("Anmeldung fehlgeschlagen");
    }
    final DateTime? expiresAt = result.accessTokenExpirationDateTime;
    if (expiresAt == null) {
      log.warning("refresh token expiry not set");
      throw const AuthenticationException("Anmeldung fehlgeschlagen");
    }

    final secureStorage = ref.watch(storagesProvider).secure;
    await secureStorage.write(key: StorageKey.idToken.key, value: idToken);
    await secureStorage.write(
      key: StorageKey.refreshToken.key,
      value: refreshToken,
    );
    await secureStorage.write(
      key: StorageKey.accessToken.key,
      value: accessToken,
    );
    await secureStorage.write(
      key: StorageKey.accessTokenExpiresAt.key,
      value: expiresAt.toIso8601String(),
    );

    final auth = AuthController(
      idToken: idToken,
      accessToken: accessToken,
      expiresAt: expiresAt,
      refreshToken: refreshToken,
      appAuth: _appAuth,
      storage: secureStorage,
    );
    return auth;
  }

  Future<AuthController> login() async {
    CancelableOperation<AuthController>? loginOperation = _login;

    if (loginOperation != null) {
      return await loginOperation.value;
    }

    loginOperation = CancelableOperation.fromFuture(
      _doLogin(),
      onCancel: () => {_login = null},
    );
    _login = loginOperation;
    try {
      return await loginOperation.value;
    } finally {
      _login = null;
    }
  }

  /// The actual logout code
  /// This will be deduplicated in logout()
  Future<bool> _doLogout() async {
    final String? idToken;
    switch (state) {
      case AsyncData(value: Authenticated(:final auth)):
        idToken = (await auth.getTokens()).id;
      default:
        return true;
    }

    try {
      await _appAuth.endSession(
        EndSessionRequest(
          issuer: F.authUrl,
          postLogoutRedirectUrl: ApiConstants.redirectUrl,
          idTokenHint: idToken,
          externalUserAgent:
              ExternalUserAgent.ephemeralAsWebAuthenticationSession,
        ),
      );
      return true;
    } on PlatformException catch (e) {
      log.severe("logout failed", e);
    } finally {
      final secureStorage = ref.watch(storagesProvider).secure;
      await secureStorage.delete(key: StorageKey.idToken.key);
      await secureStorage.delete(key: StorageKey.refreshToken.key);
      await secureStorage.delete(key: StorageKey.accessTokenExpiresAt.key);
      final sharedPreferences = ref.watch(storagesProvider).shared;
      await sharedPreferences.clear();
      state = AsyncValue.data(Unauthenticated());
      log.info("logout successful");
    }
    return false;
  }

  Future<bool> logout() async {
    log.info("logging out...");
    CancelableOperation<bool>? logoutOperation = _logout;
    if (logoutOperation != null) {
      log.info("awaiting existing completer...");
      return await (logoutOperation.value);
    }
    if (_login != null) {
      log.info("aborting running login");
      _login?.cancel();
    }
    logoutOperation = CancelableOperation.fromFuture(
      _doLogout(),
      onCancel: () => {_logout = null},
    );
    _logout = logoutOperation;
    try {
      return await logoutOperation.value;
    } finally {
      _logout = null;
    }
  }
}
