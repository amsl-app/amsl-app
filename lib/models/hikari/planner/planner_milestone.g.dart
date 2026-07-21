// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerMilestone _$PlannerMilestoneFromJson(Map<String, dynamic> json) =>
    _PlannerMilestone(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      moduleId: json['module_id'] as String?,
      originId: json['origin_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PlannerMilestoneToJson(_PlannerMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'module_id': instance.moduleId,
      'origin_id': instance.originId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
