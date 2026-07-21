// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_planner_milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewPlannerMilestone _$NewPlannerMilestoneFromJson(Map<String, dynamic> json) =>
    _NewPlannerMilestone(
      title: json['title'] as String,
      date: json['date'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$NewPlannerMilestoneToJson(
  _NewPlannerMilestone instance,
) => <String, dynamic>{
  'title': instance.title,
  'date': instance.date,
  'description': instance.description,
};
