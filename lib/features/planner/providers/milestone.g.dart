// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MilestonePod)
final milestonePodProvider = MilestonePodProvider._();

final class MilestonePodProvider
    extends
        $AsyncNotifierProvider<MilestonePod, Map<String, PlannerMilestone>> {
  MilestonePodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'milestonePodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider, plannerPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          MilestonePodProvider.$allTransitiveDependencies0,
          MilestonePodProvider.$allTransitiveDependencies1,
          MilestonePodProvider.$allTransitiveDependencies2,
          MilestonePodProvider.$allTransitiveDependencies3,
          MilestonePodProvider.$allTransitiveDependencies4,
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

  @override
  String debugGetCreateSourceHash() => _$milestonePodHash();

  @$internal
  @override
  MilestonePod create() => MilestonePod();
}

String _$milestonePodHash() => r'e30d3f262db6775192e118082ace5c1d6390ae94';

abstract class _$MilestonePod
    extends $AsyncNotifier<Map<String, PlannerMilestone>> {
  FutureOr<Map<String, PlannerMilestone>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, PlannerMilestone>>,
              Map<String, PlannerMilestone>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, PlannerMilestone>>,
                Map<String, PlannerMilestone>
              >,
              AsyncValue<Map<String, PlannerMilestone>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
