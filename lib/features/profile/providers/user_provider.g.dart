// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPod)
final userPodProvider = UserPodProvider._();

final class UserPodProvider extends $AsyncNotifierProvider<UserPod, User> {
  UserPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider, storagesProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          UserPodProvider.$allTransitiveDependencies0,
          UserPodProvider.$allTransitiveDependencies1,
          UserPodProvider.$allTransitiveDependencies2,
          UserPodProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$userPodHash();

  @$internal
  @override
  UserPod create() => UserPod();
}

String _$userPodHash() => r'd30ce5fb43e66e3731a905fc226e216f2bf6595e';

abstract class _$UserPod extends $AsyncNotifier<User> {
  FutureOr<User> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
