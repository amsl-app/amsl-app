// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranscriptRecord _$TranscriptRecordFromJson(Map<String, dynamic> json) =>
    _TranscriptRecord(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      unlocked: json['unlocked'] as bool,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => TranscriptRequirement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranscriptRecordToJson(_TranscriptRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'unlocked': instance.unlocked,
      'requirements': instance.requirements,
    };

_TranscriptRequirement _$TranscriptRequirementFromJson(
  Map<String, dynamic> json,
) => _TranscriptRequirement(
  label: json['label'] as String,
  met: json['met'] as bool,
);

Map<String, dynamic> _$TranscriptRequirementToJson(
  _TranscriptRequirement instance,
) => <String, dynamic>{'label': instance.label, 'met': instance.met};
