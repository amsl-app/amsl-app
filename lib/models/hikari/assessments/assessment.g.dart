// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assessment _$AssessmentFromJson(Map<String, dynamic> json) => Assessment(
  assessmentId: json['assessment_id'] as String,
  title: json['title'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
  scales: (json['scales'] as List<dynamic>)
      .map((e) => Scale.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AssessmentToJson(Assessment instance) =>
    <String, dynamic>{
      'assessment_id': instance.assessmentId,
      'title': instance.title,
      'questions': instance.questions,
      'scales': instance.scales,
    };
