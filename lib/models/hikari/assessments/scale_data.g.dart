// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleData _$ScaleDataFromJson(Map<String, dynamic> json) => ScaleData(
  title: json['title'] as String,
  id: json['id'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$ScaleDataToJson(ScaleData instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'value': instance.value,
};

TimedScaleData _$TimedScaleDataFromJson(Map<String, dynamic> json) =>
    TimedScaleData(
      completed: DateTime.parse(json['completed'] as String),
      scales: (json['scales'] as List<dynamic>)
          .map((e) => ScaleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimedScaleDataToJson(TimedScaleData instance) =>
    <String, dynamic>{
      'completed': instance.completed.toIso8601String(),
      'scales': instance.scales,
    };

AssessmentScaleData _$AssessmentScaleDataFromJson(Map<String, dynamic> json) =>
    AssessmentScaleData(
      assessmentId: json['assessment_id'] as String,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => TimedScaleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssessmentScaleDataToJson(
  AssessmentScaleData instance,
) => <String, dynamic>{
  'assessment_id': instance.assessmentId,
  'sessions': instance.sessions,
};
