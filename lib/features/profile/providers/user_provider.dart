import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/models/hikari/user/access_approvals.dart';
import 'package:amsl_app/models/hikari/user/user.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/exception.dart';
import '../../../hikari/hikari.dart';
import '../../../providers/hikari_provider.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod, storages])
class UserPod extends _$UserPod {
  static final log = Logger("UserProvider");

  @override
  Future<User> build() async {
    final hikari = ref.watch(hikariPodProvider);
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final user = await _loadUserFromApi(hikari);
    return user;
  }

  Future<User> _loadUserFromApi(Hikari hikari) async {
    log.info("Loading user");
    try {
      final user = await hikari.userApi.getUser();
      log.info("Loaded ${user.name} with variant ${user.variant}");
      return user;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadUser);
    }
  }

  Future<User> reloadUser() async {
    ref.invalidateSelf();
    return future;
  }

  Future<void> patchUser({required String? name}) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.userApi.patchUser(name: name);
      await reloadUser();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => patchUser(name: name));
    }
  }

  Future<String> generateSurveyCode() async {
    final hikari = ref.read(hikariPodProvider);

    try {
      return hikari.userApi.userHandle();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: generateSurveyCode);
    }
  }

  Future<AccessApprovals?> getAccessApprovals(String token) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      return hikari.userApi.getAccessTokenApprovals(token);
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => getAccessApprovals(token));
    }
  }

  Future<void> postAccessToken(String token) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.userApi.postAccessToken(token);
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => postAccessToken(token));
    }
  }
}
