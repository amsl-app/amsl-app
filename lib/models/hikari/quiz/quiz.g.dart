// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
  id: json['id'] as String,
  moduleId: json['module_id'] as String,
  status: $enumDecode(_$QuizStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
  sessionIds: (json['session_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Question>[],
);

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
  'id': instance.id,
  'module_id': instance.moduleId,
  'status': _$QuizStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
  'session_ids': instance.sessionIds,
  'questions': instance.questions,
};

const _$QuizStatusEnumMap = {
  QuizStatus.open: 'open',
  QuizStatus.closed: 'closed',
};
