// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizScore _$QuizScoreFromJson(Map<String, dynamic> json) => _QuizScore(
  moduleId: json['module_id'] as String,
  sessionId: json['session_id'] as String,
  topic: json['topic'] as String,
  score: (json['score'] as num).toInt(),
);

Map<String, dynamic> _$QuizScoreToJson(_QuizScore instance) =>
    <String, dynamic>{
      'module_id': instance.moduleId,
      'session_id': instance.sessionId,
      'topic': instance.topic,
      'score': instance.score,
    };
