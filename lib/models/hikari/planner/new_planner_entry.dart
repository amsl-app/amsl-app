import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_planner_entry.freezed.dart';
part 'new_planner_entry.g.dart';

@freezed
abstract class NewPlannerEntry with _$NewPlannerEntry {
  factory NewPlannerEntry({
    required String date,
    required String title,
    required int priority,
    @JsonKey(name: 'module_id') String? moduleId,
    @JsonKey(name: 'session_id') String? sessionId,
  }) = _NewPlannerEntry;

  factory NewPlannerEntry.fromJson(Map<String, dynamic> json) =>
      _$NewPlannerEntryFromJson(json);
}
