import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/models/tori/planner/planner_config.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'planner_configuration.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod, PlannerPod, MilestonePod, GoalPod])
class PlannerConfigPod extends _$PlannerConfigPod {
  @override
  Future<PlannerConfig> build() async {
    final asyncEntries = ref.watch(plannerPodProvider.future);
    final asyncMilestones = ref.watch(milestonePodProvider.future);
    final asyncGoals = ref.watch(goalPodProvider.future);

    final results = await Future.wait([
      asyncEntries,
      asyncMilestones,
      asyncGoals,
    ]);

    return PlannerConfig(
      entries: results[0] as List<PlannerEntry>,
      milestones: results[1] as Map<String, PlannerMilestone>,
      goals: results[2] as Map<String, PlannerGoal>,
    );
  }
}
