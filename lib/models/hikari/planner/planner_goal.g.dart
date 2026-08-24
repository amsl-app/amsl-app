// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerGoal _$PlannerGoalFromJson(Map<String, dynamic> json) => _PlannerGoal(
  id: json['id'] as String,
  name: json['name'] as String,
  fullfilled: json['fullfilled'] as bool,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PlannerGoalToJson(_PlannerGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fullfilled': instance.fullfilled,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
