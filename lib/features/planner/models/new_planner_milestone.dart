import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_planner_milestone.freezed.dart';
part 'new_planner_milestone.g.dart';

@freezed
abstract class NewPlannerMilestone with _$NewPlannerMilestone {
  factory NewPlannerMilestone({
    required String title,
    required String date,
    String? description,
  }) = _NewPlannerMilestone;

  factory NewPlannerMilestone.fromJson(Map<String, dynamic> json) =>
      _$NewPlannerMilestoneFromJson(json);
}
