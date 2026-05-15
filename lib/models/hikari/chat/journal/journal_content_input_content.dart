import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'journal_content_input_content.g.dart';

@JsonSerializable()
class JournalContentInputContent {
  static final log = Logger('JournalContentInputContent');

  final String prompt;
  @JsonKey(name: "require_assistant", defaultValue: false)
  final bool requireAssistant;

  JournalContentInputContent({
    required this.prompt,
    required this.requireAssistant,
  });

  factory JournalContentInputContent.fromJson(Map<String, dynamic> json) {
    log.fine("JournalContentInputContent.fromJson: $json");

    return _$JournalContentInputContentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$JournalContentInputContentToJson(this);
}
