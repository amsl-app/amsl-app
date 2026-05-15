import 'package:json_annotation/json_annotation.dart';

part 'journal_summary.g.dart';

@JsonSerializable()
class JournalSummary {
  final String summary;
  @JsonKey(name: 'topic_summaries')
  final List<SummaryTopic> topics;

  JournalSummary({required this.summary, required this.topics});

  factory JournalSummary.fromJson(Map<String, dynamic> json) =>
      _$JournalSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$JournalSummaryToJson(this);
}

@JsonSerializable()
class SummaryTopic {
  final String topic;
  final String summary;

  SummaryTopic({required this.topic, required this.summary});

  factory SummaryTopic.fromJson(Map<String, dynamic> json) =>
      _$SummaryTopicFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryTopicToJson(this);
}
