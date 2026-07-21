// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_configuration.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlannerConfigPod)
final plannerConfigPodProvider = PlannerConfigPodProvider._();

final class PlannerConfigPodProvider
    extends $AsyncNotifierProvider<PlannerConfigPod, PlannerConfig> {
  PlannerConfigPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plannerConfigPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          hikariPodProvider,
          plannerPodProvider,
          milestonePodProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          PlannerConfigPodProvider.$allTransitiveDependencies0,
          PlannerConfigPodProvider.$allTransitiveDependencies1,
          PlannerConfigPodProvider.$allTransitiveDependencies2,
          PlannerConfigPodProvider.$allTransitiveDependencies3,
          PlannerConfigPodProvider.$allTransitiveDependencies4,
          PlannerConfigPodProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = plannerPodProvider;
  static final $allTransitiveDependencies5 = milestonePodProvider;

  @override
  String debugGetCreateSourceHash() => _$plannerConfigPodHash();

  @$internal
  @override
  PlannerConfigPod create() => PlannerConfigPod();
}

String _$plannerConfigPodHash() => r'887456a53bd9dfd5b549bfc05bb49f25f8bf0882';

abstract class _$PlannerConfigPod extends $AsyncNotifier<PlannerConfig> {
  FutureOr<PlannerConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PlannerConfig>, PlannerConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlannerConfig>, PlannerConfig>,
              AsyncValue<PlannerConfig>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
