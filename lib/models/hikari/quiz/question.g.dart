// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionOptions _$QuestionOptionsFromJson(Map<String, dynamic> json) =>
    _QuestionOptions(
      option: json['option'] as String,
      correct: json['correct'] as bool?,
    );

Map<String, dynamic> _$QuestionOptionsToJson(_QuestionOptions instance) =>
    <String, dynamic>{'option': instance.option, 'correct': instance.correct};

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  quizId: json['quiz_id'] as String,
  sessionId: json['session_id'] as String,
  topic: json['topic'] as String,
  content: json['content'] as String,
  question: json['question'] as String,
  level: $enumDecode(_$BloomLevelEnumMap, json['level']),
  status: $enumDecode(_$QuestionStatusEnumMap, json['status']),
  type:
      $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']) ??
      QuestionType.text,
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => QuestionOptions.fromJson(e as Map<String, dynamic>))
      .toList(),
  aiSolution: json['ai_solution'] as String?,
  answer: json['answer'] as String?,
  evaluation: json['evaluation'] as String?,
  grade: (json['grade'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'quiz_id': instance.quizId,
  'session_id': instance.sessionId,
  'topic': instance.topic,
  'content': instance.content,
  'question': instance.question,
  'level': _$BloomLevelEnumMap[instance.level]!,
  'status': _$QuestionStatusEnumMap[instance.status]!,
  'type': _$QuestionTypeEnumMap[instance.type]!,
  'options': instance.options,
  'ai_solution': instance.aiSolution,
  'answer': instance.answer,
  'evaluation': instance.evaluation,
  'grade': instance.grade,
};

const _$BloomLevelEnumMap = {
  BloomLevel.remember: 'remember',
  BloomLevel.understand: 'understand',
  BloomLevel.apply: 'apply',
  BloomLevel.analyze: 'analyze',
  BloomLevel.evaluate: 'evaluate',
  BloomLevel.create: 'create',
};

const _$QuestionStatusEnumMap = {
  QuestionStatus.open: 'open',
  QuestionStatus.finished: 'finished',
  QuestionStatus.skipped: 'skipped',
};

const _$QuestionTypeEnumMap = {
  QuestionType.multipleChoice: 'multiple_choice',
  QuestionType.text: 'text',
};
