import 'package:freezed_annotation/freezed_annotation.dart';

import 'planner_milestone.dart';

part 'planner_entry.freezed.dart';
part 'planner_entry.g.dart';

@freezed
abstract class PlannerEntry with _$PlannerEntry {
  factory PlannerEntry({
    required String id,
    required DateTime date,
    @JsonKey(name: 'effective_date') required DateTime effectiveDate,
    required String title,
    required bool completed,
    required int priority,
    PlannerMilestone? milestone,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PlannerEntry;

  factory PlannerEntry.fromJson(Map<String, dynamic> json) =>
      _$PlannerEntryFromJson(json);
}
