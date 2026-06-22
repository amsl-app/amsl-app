// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerEntry _$PlannerEntryFromJson(Map<String, dynamic> json) =>
    _PlannerEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      completed: json['completed'] as bool,
      priority: (json['priority'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      moduleId: json['module_id'] as String?,
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$PlannerEntryToJson(_PlannerEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'completed': instance.completed,
      'priority': instance.priority,
      'created_at': instance.createdAt.toIso8601String(),
      'module_id': instance.moduleId,
      'session_id': instance.sessionId,
    };
