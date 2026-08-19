// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerEntry _$PlannerEntryFromJson(Map<String, dynamic> json) =>
    _PlannerEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      effectiveDate: DateTime.parse(json['effective_date'] as String),
      title: json['title'] as String,
      completed: json['completed'] as bool,
      priority: (json['priority'] as num).toInt(),
      milestone: json['milestone'] == null
          ? null
          : PlannerMilestone.fromJson(
              json['milestone'] as Map<String, dynamic>,
            ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PlannerEntryToJson(_PlannerEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'effective_date': instance.effectiveDate.toIso8601String(),
      'title': instance.title,
      'completed': instance.completed,
      'priority': instance.priority,
      'milestone': instance.milestone,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
