import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_entry.freezed.dart';
part 'planner_entry.g.dart';

@freezed
abstract class PlannerEntry with _$PlannerEntry {
  factory PlannerEntry({
    required String id,
    required DateTime date,
    required String title,
    required bool completed,
    required int priority,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'module_id') String? moduleId,
    @JsonKey(name: 'session_id') String? sessionId,
  }) = _PlannerEntry;

  factory PlannerEntry.fromJson(Map<String, dynamic> json) =>
      _$PlannerEntryFromJson(json);
}
