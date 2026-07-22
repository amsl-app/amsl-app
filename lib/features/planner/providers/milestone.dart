import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/features/planner/models/new_planner_milestone.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'milestone.g.dart';

/// Groups milestones by their day (time component stripped), preserving order.
Map<DateTime, List<PlannerMilestone>> groupMilestonesByDay(
  Iterable<PlannerMilestone> milestones,
) {
  final map = <DateTime, List<PlannerMilestone>>{};
  for (final m in milestones) {
    final day = DateTime(m.date.year, m.date.month, m.date.day);
    map.putIfAbsent(day, () => []).add(m);
  }
  return map;
}

@Riverpod(keepAlive: true, dependencies: [HikariPod, PlannerPod])
class MilestonePod extends _$MilestonePod {
  @override
  Future<Map<String, PlannerMilestone>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    return _loadMilestonesFromApi(hikari);
  }

  Future<Map<String, PlannerMilestone>> _loadMilestonesFromApi(
    Hikari hikari,
  ) async {
    try {
      final milestones = await hikari.plannerApi.getMilestones();
      return {
        for (final m in milestones.map(PlannerMilestone.fromHikari)) m.id: m,
      };
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadMilestones);
    }
  }

  Future<Map<String, PlannerMilestone>> reloadMilestones() async {
    ref.invalidateSelf();
    return future;
  }

  Future<PlannerMilestone> createMilestone(
    NewPlannerMilestone milestone,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final created = PlannerMilestone.fromHikari(
        await hikari.plannerApi.createMilestone(milestone),
      );
      update((milestones) async => {...milestones, created.id: created});
      return created;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => createMilestone(milestone));
    }
  }

  Future<PlannerMilestone> updateMilestone(
    String id, {
    String? title,
    String? date,
    String? description,
    bool clearDescription = false,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final updated = PlannerMilestone.fromHikari(
        await hikari.plannerApi.updateMilestone(
          id,
          title: title,
          date: date,
          description: description,
          clearDescription: clearDescription,
        ),
      );
      update((milestones) async => {...milestones, id: updated});
      return updated;
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => updateMilestone(
          id,
          title: title,
          date: date,
          description: description,
          clearDescription: clearDescription,
        ),
      );
    }
  }

  Future<void> deleteMilestone(String id) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.plannerApi.deleteMilestone(id);
      update((milestones) async => {...milestones}..remove(id));
      // Deleting a milestone clears `milestone_id` on any linked entries
      // server-side (ON DELETE SET NULL) — refetch to drop the stale link.
      ref.read(plannerPodProvider.notifier).reloadEntries();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => deleteMilestone(id));
    }
  }
}
