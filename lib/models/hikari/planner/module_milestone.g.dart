// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModuleMilestone _$ModuleMilestoneFromJson(Map<String, dynamic> json) =>
    _ModuleMilestone(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      alreadyImported: json['already_imported'] as bool,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ModuleMilestoneToJson(_ModuleMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'already_imported': instance.alreadyImported,
      'description': instance.description,
    };
