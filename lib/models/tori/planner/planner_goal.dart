import 'package:amsl_app/models/hikari/planner/planner_goal.dart'
    as hikari_planner;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_goal.freezed.dart';

@freezed
abstract class PlannerGoal with _$PlannerGoal {
  factory PlannerGoal({
    required String id,
    required String name,
    required bool fullfilled,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlannerGoal;

  factory PlannerGoal.fromHikari(hikari_planner.PlannerGoal g) => PlannerGoal(
    id: g.id,
    name: g.name,
    fullfilled: g.fullfilled,
    description: g.description,
    createdAt: g.createdAt,
    updatedAt: g.updatedAt,
  );
}

extension PlannerGoalToHikari on PlannerGoal {
  hikari_planner.PlannerGoal toHikari() => hikari_planner.PlannerGoal(
    id: id,
    name: name,
    fullfilled: fullfilled,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
