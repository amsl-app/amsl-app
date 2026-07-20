import 'package:amsl_app/models/hikari/planner/planner_entry.dart'
    as hikari_planner;
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
    required DateTime createdAt,
    String? moduleId,
    String? sessionId,
  }) = _PlannerEntry;

  factory PlannerEntry.fromHikari(hikari_planner.PlannerEntry entry) =>
      PlannerEntry(
        id: entry.id,
        date: entry.date,
        title: entry.title,
        completed: entry.completed,
        priority: entry.priority,
        createdAt: entry.createdAt,
        moduleId: entry.moduleId,
        sessionId: entry.sessionId,
      );
}
