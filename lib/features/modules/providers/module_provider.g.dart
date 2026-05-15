// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModuleNotifier)
final moduleProvider = ModuleNotifierProvider._();

final class ModuleNotifierProvider
    extends
        $AsyncNotifierProvider<
          ModuleNotifier,
          Map<String, ModuleAssessmentSet>
        > {
  ModuleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          hikariPodProvider,
          assessmentSessionsProvider,
          moduleGroupsProviderProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ModuleNotifierProvider.$allTransitiveDependencies0,
          ModuleNotifierProvider.$allTransitiveDependencies1,
          ModuleNotifierProvider.$allTransitiveDependencies2,
          ModuleNotifierProvider.$allTransitiveDependencies3,
          ModuleNotifierProvider.$allTransitiveDependencies4,
          ModuleNotifierProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = assessmentSessionsProvider;
  static final $allTransitiveDependencies5 = moduleGroupsProviderProvider;

  @override
  String debugGetCreateSourceHash() => _$moduleNotifierHash();

  @$internal
  @override
  ModuleNotifier create() => ModuleNotifier();
}

String _$moduleNotifierHash() => r'8d5b5c406c03248f1c74d3021cc9468ab4161062';

abstract class _$ModuleNotifier
    extends $AsyncNotifier<Map<String, ModuleAssessmentSet>> {
  FutureOr<Map<String, ModuleAssessmentSet>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, ModuleAssessmentSet>>,
              Map<String, ModuleAssessmentSet>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, ModuleAssessmentSet>>,
                Map<String, ModuleAssessmentSet>
              >,
              AsyncValue<Map<String, ModuleAssessmentSet>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
