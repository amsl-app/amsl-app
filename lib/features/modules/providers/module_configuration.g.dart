// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_configuration.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModuleConfigurationProvider)
final moduleConfigurationProviderProvider =
    ModuleConfigurationProviderProvider._();

final class ModuleConfigurationProviderProvider
    extends
        $AsyncNotifierProvider<
          ModuleConfigurationProvider,
          ModuleConfiguration
        > {
  ModuleConfigurationProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleConfigurationProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          hikariPodProvider,
          moduleProvider,
          moduleGroupsProviderProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ModuleConfigurationProviderProvider.$allTransitiveDependencies0,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies1,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies2,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies3,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies4,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies5,
          ModuleConfigurationProviderProvider.$allTransitiveDependencies6,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = moduleProvider;
  static final $allTransitiveDependencies5 =
      ModuleNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      ModuleNotifierProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$moduleConfigurationProviderHash();

  @$internal
  @override
  ModuleConfigurationProvider create() => ModuleConfigurationProvider();
}

String _$moduleConfigurationProviderHash() =>
    r'a7b62c2cb46427778eadafa0320016b95f2a5c47';

abstract class _$ModuleConfigurationProvider
    extends $AsyncNotifier<ModuleConfiguration> {
  FutureOr<ModuleConfiguration> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ModuleConfiguration>, ModuleConfiguration>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ModuleConfiguration>, ModuleConfiguration>,
              AsyncValue<ModuleConfiguration>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
