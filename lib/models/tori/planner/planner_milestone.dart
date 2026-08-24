import 'package:amsl_app/models/hikari/planner/planner_milestone.dart'
    as hikari_planner;
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_milestone.freezed.dart';

@freezed
abstract class PlannerMilestone with _$PlannerMilestone {
  const PlannerMilestone._();

  const factory PlannerMilestone({
    required String id,
    required String title,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<PlannerGoal> goals,
    String? description,
    String? moduleId,
    String? originId,
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
        goals: m.goals.map((g) => PlannerGoal.fromHikari(g)).toList(),
      );
}
