import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [AsyncLoginNotifier])
LoginState login(Ref ref) {
  final asyncAuth = ref.watch(asyncLoginProvider);
  final authState = switch (asyncAuth) {
    AsyncData() => asyncAuth.value,
    _ => Unauthenticated(),
  };
  return authState;
}
