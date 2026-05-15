import 'package:json_annotation/json_annotation.dart';

part 'journal_title_input_content.g.dart';

@JsonSerializable()
class JournalTitleInputContent {
  final String? prompt;

  JournalTitleInputContent({required this.prompt});

  factory JournalTitleInputContent.fromJson(Map<String, dynamic> json) =>
      _$JournalTitleInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$JournalTitleInputContentToJson(this);
}
