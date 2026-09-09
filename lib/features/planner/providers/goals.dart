import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goals.g.dart';

/// Groups goals by their day (time component stripped), preserving order.
Map<DateTime, List<PlannerGoal>> groupGoalsByDay(Iterable<PlannerGoal> goals) {
  final map = <DateTime, List<PlannerGoal>>{};
  for (final g in goals) {
    final day = DateTime(g.date.year, g.date.month, g.date.day);
    map.putIfAbsent(day, () => []).add(g);
  }
  return map;
}

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
    required String date,
    String? description,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final goal = PlannerGoal.fromHikari(
        await hikari.plannerApi.createGoal(
          name: name,
          date: date,
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
    String? date,
    bool? fulfilled,
    String? description,
    bool clearDescription = false,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final updated = PlannerGoal.fromHikari(
        await hikari.plannerApi.updateGoal(
          goalId,
          name: name,
          date: date,
          fulfilled: fulfilled,
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
