import 'package:amsl_app/models/hikari/planner/planner_milestone.dart'
    as hikari_planner;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_milestone.freezed.dart';

@freezed
abstract class PlannerMilestone with _$PlannerMilestone {
  const PlannerMilestone._();

  const factory PlannerMilestone({
    required String id,
    required String title,
    required DateTime date,
    String? description,
    String? moduleId,
    String? originId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlannerMilestone;

  factory PlannerMilestone.fromHikari(hikari_planner.PlannerMilestone m) =>
      PlannerMilestone(
        id: m.id,
        title: m.title,
        date: m.date,
        description: m.description,
        moduleId: m.moduleId,
        originId: m.originId,
        createdAt: m.createdAt,
        updatedAt: m.updatedAt,
      );
}
