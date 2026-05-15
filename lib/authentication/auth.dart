import 'dart:async';

import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/flavors.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

const Duration refreshOffset = Duration(minutes: 1);

class Tokens {
  final String id;
  final String access;

  Tokens({required this.id, required this.access});
}

class AuthController {
  static final log = Logger("AuthController");
  DateTime _expiresAt;
  Tokens _tokens;
  String _refreshToken;
  final FlutterSecureStorage _storage;
  final FlutterAppAuth _appAuth;
  Completer<Tokens>? _refresh;

  AuthController({
    required String idToken,
    required DateTime expiresAt,
    required String accessToken,
    required String refreshToken,
    required FlutterAppAuth appAuth,
    required FlutterSecureStorage storage,
  }) : _refreshToken = refreshToken,
       _tokens = Tokens(id: idToken, access: accessToken),
       _expiresAt = expiresAt,
       _storage = storage,
       _appAuth = appAuth {
    log.fine("initialized auth controller. tokens expire at: $_expiresAt");
    debugPrint("accessToken: $accessToken");
  }

  Future<Tokens> refresh() async {
    Completer<Tokens>? completer = _refresh;
    if (completer != null) {
      return await completer.future;
    }

    completer = Completer();
    _refresh = completer;
    try {
      log.info("refreshing access token which expires at $_expiresAt");
      final response = await _appAuth.token(
        TokenRequest(
          F.authClientId,
          ApiConstants.redirectUrl,
          issuer: F.authUrl,
          refreshToken: _refreshToken,
          scopes: ApiConstants.scopes,
        ),
      );

      final refreshToken = response.refreshToken;
      if (refreshToken == null) {
        log.severe("refesh token missing from token response");
        throw const AuthenticationException("Token refresh fehlgeschlagen");
      }

      final idToken = response.idToken;
      if (idToken == null) {
        log.severe("id token token missing from token response");
        throw const AuthenticationException("Token refresh fehlgeschlagen");
      }

      final accessToken = response.accessToken;
      if (accessToken == null) {
        log.severe("access token missing from token response");
        throw const AuthenticationException("Token refresh fehlgeschlagen");
      }

      final accessTokenExpiresAt = response.accessTokenExpirationDateTime;
      if (accessTokenExpiresAt == null) {
        log.severe("access token expiry missing from token response");
        throw const AuthenticationException("Token refresh fehlgeschlagen");
      }

      await _storage.write(
        key: StorageKey.refreshToken.key,
        value: refreshToken,
      );
      await _storage.write(key: StorageKey.idToken.key, value: idToken);
      await _storage.write(key: StorageKey.accessToken.key, value: accessToken);
      await _storage.write(
        key: StorageKey.accessTokenExpiresAt.key,
        value: accessTokenExpiresAt.toIso8601String(),
      );
      log.info("updated token. new token expires at: $accessTokenExpiresAt");
      _tokens = Tokens(id: idToken, access: accessToken);
      _expiresAt = accessTokenExpiresAt;
      _refreshToken = refreshToken;
      completer.complete(_tokens);
      return _tokens;
    } catch (err) {
      log.severe("error refreshing token", err);
      completer.completeError(err);
      rethrow;
    } finally {
      _refresh = null;
    }
  }

  Future<Tokens> getTokens() async {
    final refresh = _refresh;
    Tokens tokens = _tokens;
    try {
      if (refresh != null) {
        tokens = await refresh.future;
      } else if (DateTime.now().isAfter(_expiresAt.add(refreshOffset))) {
        tokens = await this.refresh();
      }
    } on Exception catch (e) {
      log.severe("Failed to get tokens: $e");
    }
    return tokens;
  }
}
