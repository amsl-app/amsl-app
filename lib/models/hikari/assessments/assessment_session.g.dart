// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentSession _$AssessmentSessionFromJson(Map<String, dynamic> json) =>
    AssessmentSession(
      assessment: Assessment.fromJson(
        json['assessment'] as Map<String, dynamic>,
      ),
      sessionId: json['session_id'] as String,
      status: $enumDecode(_$AssessmentStatusEnumMap, json['status']),
      completed: json['completed'] == null
          ? null
          : DateTime.parse(json['completed'] as String),
    );

Map<String, dynamic> _$AssessmentSessionToJson(AssessmentSession instance) =>
    <String, dynamic>{
      'assessment': instance.assessment,
      'session_id': instance.sessionId,
      'status': _$AssessmentStatusEnumMap[instance.status]!,
      'completed': instance.completed?.toIso8601String(),
    };

const _$AssessmentStatusEnumMap = {
  AssessmentStatus.notStarted: 'not_started',
  AssessmentStatus.running: 'running',
  AssessmentStatus.finished: 'finished',
};
