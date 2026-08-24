import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goals.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class GoalPod extends _$GoalPod {
  @override
  Future<Map<String, PlannerGoal>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    return _loadGoalsFromApi(hikari);
  }

  Future<Map<String, PlannerGoal>> _loadGoalsFromApi(Hikari hikari) async {
    try {
      final goals = await hikari.plannerApi.getGoals();
      return {for (final g in goals.map(PlannerGoal.fromHikari)) g.id: g};
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadGoals);
    }
  }

  Future<Map<String, PlannerGoal>> reloadGoals() async {
    ref.invalidateSelf();
    return future;
  }

  Future<PlannerGoal> createGoal({
    required String name,
    String? description,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final goal = PlannerGoal.fromHikari(
        await hikari.plannerApi.createGoal(
          name: name,
          description: description,
        ),
      );
      update((goals) async => {...goals, goal.id: goal});
      return goal;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadGoals);
    }
  }

  Future<PlannerGoal> updateGoal(
    String goalId, {
    String? name,
    bool? fullfilled,
    String? description,
    bool clearDescription = false,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final updated = PlannerGoal.fromHikari(
        await hikari.plannerApi.updateGoal(
          goalId,
          name: name,
          fullfilled: fullfilled,
          description: description,
          clearDescription: clearDescription,
        ),
      );
      update((goals) async => {...goals, updated.id: updated});
      return updated;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadGoals);
    }
  }

  Future<void> deleteGoal(String goalId) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.plannerApi.deleteGoal(goalId);
      update((goals) async => {...goals}..remove(goalId));

      ref.read(milestonePodProvider.notifier).reloadMilestones();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadGoals);
    }
  }
}
