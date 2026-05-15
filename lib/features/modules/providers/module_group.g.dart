// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_group.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModuleGroupsProvider)
final moduleGroupsProviderProvider = ModuleGroupsProviderProvider._();

final class ModuleGroupsProviderProvider
    extends
        $AsyncNotifierProvider<ModuleGroupsProvider, Map<String, ModuleGroup>> {
  ModuleGroupsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleGroupsProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ModuleGroupsProviderProvider.$allTransitiveDependencies0,
          ModuleGroupsProviderProvider.$allTransitiveDependencies1,
          ModuleGroupsProviderProvider.$allTransitiveDependencies2,
          ModuleGroupsProviderProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$moduleGroupsProviderHash();

  @$internal
  @override
  ModuleGroupsProvider create() => ModuleGroupsProvider();
}

String _$moduleGroupsProviderHash() =>
    r'31b210bf06dcc4868ffca6810ce0d1aac6500fa1';

abstract class _$ModuleGroupsProvider
    extends $AsyncNotifier<Map<String, ModuleGroup>> {
  FutureOr<Map<String, ModuleGroup>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, ModuleGroup>>,
              Map<String, ModuleGroup>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, ModuleGroup>>,
                Map<String, ModuleGroup>
              >,
              AsyncValue<Map<String, ModuleGroup>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
