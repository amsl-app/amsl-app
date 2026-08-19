import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_milestone.freezed.dart';
part 'planner_milestone.g.dart';

@freezed
abstract class PlannerMilestone with _$PlannerMilestone {
  factory PlannerMilestone({
    required String id,
    required String title,
    required DateTime date,
    String? description,
    @JsonKey(name: 'module_id') String? moduleId,
    @JsonKey(name: 'origin_id') String? originId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PlannerMilestone;

  factory PlannerMilestone.fromJson(Map<String, dynamic> json) =>
      _$PlannerMilestoneFromJson(json);
}
