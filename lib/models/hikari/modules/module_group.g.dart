// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleGroup _$ModuleGroupFromJson(Map<String, dynamic> json) => ModuleGroup(
  key: json['key'] as String,
  label: json['label'] as String,
  moduleIDs: (json['modules'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  weight: (json['weight'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ModuleGroupToJson(ModuleGroup instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'modules': instance.moduleIDs,
      'weight': instance.weight,
    };
