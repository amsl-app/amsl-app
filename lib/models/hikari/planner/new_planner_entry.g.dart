// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_planner_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewPlannerEntry _$NewPlannerEntryFromJson(Map<String, dynamic> json) =>
    _NewPlannerEntry(
      date: json['date'] as String,
      title: json['title'] as String,
      priority: (json['priority'] as num).toInt(),
      moduleId: json['module_id'] as String?,
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$NewPlannerEntryToJson(_NewPlannerEntry instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'priority': instance.priority,
      'module_id': instance.moduleId,
      'session_id': instance.sessionId,
    };
