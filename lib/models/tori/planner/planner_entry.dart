import 'package:amsl_app/models/hikari/planner/planner_entry.dart'
    as hikari_planner;
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_entry.freezed.dart';

@freezed
abstract class PlannerEntry with _$PlannerEntry {
  const PlannerEntry._();

  const factory PlannerEntry({
    required String id,
    required DateTime date,
    required String title,
    required bool completed,
    required int priority,
    PlannerMilestone? milestone,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlannerEntry;

  factory PlannerEntry.fromHikari(hikari_planner.PlannerEntry entry) =>
      PlannerEntry(
        id: entry.id,
        date: entry.date,
        title: entry.title,
        completed: entry.completed,
        priority: entry.priority,
        milestone: entry.milestone == null
            ? null
            : PlannerMilestone.fromHikari(entry.milestone!),
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
      );
}
