import 'package:freezed_annotation/freezed_annotation.dart';

part 'assistant_prompt.g.dart';

@JsonSerializable()
class AssistantPrompt {
  final String summary;
  final String prompt;

  AssistantPrompt({required this.summary, required this.prompt});

  factory AssistantPrompt.fromJson(Map<String, dynamic> json) =>
      _$AssistantPromptFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantPromptToJson(this);
}
