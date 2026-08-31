// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerGoal _$PlannerGoalFromJson(Map<String, dynamic> json) => _PlannerGoal(
  id: json['id'] as String,
  name: json['name'] as String,
  fulfilled: json['fulfilled'] as bool? ?? false,
  description: json['description'] as String?,
  date: _dateFromJson(json['date']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PlannerGoalToJson(_PlannerGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fulfilled': instance.fulfilled,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
