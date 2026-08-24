// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoalPod)
final goalPodProvider = GoalPodProvider._();

final class GoalPodProvider
    extends $AsyncNotifierProvider<GoalPod, Map<String, PlannerGoal>> {
  GoalPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          GoalPodProvider.$allTransitiveDependencies0,
          GoalPodProvider.$allTransitiveDependencies1,
          GoalPodProvider.$allTransitiveDependencies2,
          GoalPodProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$goalPodHash();

  @$internal
  @override
  GoalPod create() => GoalPod();
}

String _$goalPodHash() => r'ce805bbb254bbefa7130c5fdca67046261249e85';

abstract class _$GoalPod extends $AsyncNotifier<Map<String, PlannerGoal>> {
  FutureOr<Map<String, PlannerGoal>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, PlannerGoal>>,
              Map<String, PlannerGoal>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, PlannerGoal>>,
                Map<String, PlannerGoal>
              >,
              AsyncValue<Map<String, PlannerGoal>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
