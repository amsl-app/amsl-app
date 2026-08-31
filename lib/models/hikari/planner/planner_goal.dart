import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_goal.freezed.dart';
part 'planner_goal.g.dart';

DateTime _dateFromJson(dynamic value) =>
    value == null ? DateTime.now() : DateTime.parse(value as String);

@freezed
abstract class PlannerGoal with _$PlannerGoal {
  factory PlannerGoal({
    required String id,
    required String name,
    @JsonKey(defaultValue: false) required bool fulfilled,
    String? description,
    @JsonKey(fromJson: _dateFromJson) required DateTime date,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PlannerGoal;

  factory PlannerGoal.fromJson(Map<String, dynamic> json) =>
      _$PlannerGoalFromJson(json);
}
