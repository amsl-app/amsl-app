// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentHistoryModel _$AssessmentHistoryModelFromJson(
  Map<String, dynamic> json,
) => AssessmentHistoryModel(
  completed: DateTime.parse(json['completed'] as String),
  type: $enumDecode(_$HistoryTypeEnumMap, json['type']),
  assessmentType: json['assessment_type'] as String,
  sessionId: json['session_id'] as String,
);

Map<String, dynamic> _$AssessmentHistoryModelToJson(
  AssessmentHistoryModel instance,
) => <String, dynamic>{
  'completed': instance.completed.toIso8601String(),
  'type': _$HistoryTypeEnumMap[instance.type]!,
  'assessment_type': instance.assessmentType,
  'session_id': instance.sessionId,
};

const _$HistoryTypeEnumMap = {
  HistoryType.assessment: 'Assessment',
  HistoryType.module: 'Module',
  HistoryType.session: 'Session',
};

ModuleHistoryModel _$ModuleHistoryModelFromJson(Map<String, dynamic> json) =>
    ModuleHistoryModel(
      completed: DateTime.parse(json['completed'] as String),
      type: $enumDecode(_$HistoryTypeEnumMap, json['type']),
      module: json['module'] as String,
    );

Map<String, dynamic> _$ModuleHistoryModelToJson(ModuleHistoryModel instance) =>
    <String, dynamic>{
      'completed': instance.completed.toIso8601String(),
      'type': _$HistoryTypeEnumMap[instance.type]!,
      'module': instance.module,
    };

SessionHistoryModel _$SessionHistoryModelFromJson(Map<String, dynamic> json) =>
    SessionHistoryModel(
      completed: DateTime.parse(json['completed'] as String),
      type: $enumDecode(_$HistoryTypeEnumMap, json['type']),
      module: json['module'] as String,
      session: json['session'] as String,
    );

Map<String, dynamic> _$SessionHistoryModelToJson(
  SessionHistoryModel instance,
) => <String, dynamic>{
  'completed': instance.completed.toIso8601String(),
  'type': _$HistoryTypeEnumMap[instance.type]!,
  'module': instance.module,
  'session': instance.session,
};
