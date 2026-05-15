// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalSummary _$JournalSummaryFromJson(Map<String, dynamic> json) =>
    JournalSummary(
      summary: json['summary'] as String,
      topics: (json['topic_summaries'] as List<dynamic>)
          .map((e) => SummaryTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JournalSummaryToJson(JournalSummary instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'topic_summaries': instance.topics,
    };

SummaryTopic _$SummaryTopicFromJson(Map<String, dynamic> json) => SummaryTopic(
  topic: json['topic'] as String,
  summary: json['summary'] as String,
);

Map<String, dynamic> _$SummaryTopicToJson(SummaryTopic instance) =>
    <String, dynamic>{'topic': instance.topic, 'summary': instance.summary};
