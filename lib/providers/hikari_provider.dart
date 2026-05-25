import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:amsl_app/authentication/login_provider.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../hikari/hikari.dart';

part 'hikari_provider.g.dart';

class HikariNotInitializedException implements Exception {
  @override
  String toString() {
    return "Hikari not initialized";
  }
}

@Riverpod(keepAlive: true, dependencies: [login, AsyncLoginNotifier])
class HikariPod extends _$HikariPod {
  static final log = Logger("HikariProvider");

  @override
  Hikari build() {
    final logInState = ref.watch(loginProvider);
    if (logInState is Authenticated) {
      return Hikari(
        apiClient: HikariApiClient(
          authController: logInState.auth,
          onUnauthorized: ref.read(asyncLoginProvider.notifier).logout,
        ),
      );
    }
    throw AuthenticationException("unauthenticated");
  }
}
