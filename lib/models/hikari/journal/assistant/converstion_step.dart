import 'package:freezed_annotation/freezed_annotation.dart';

part 'converstion_step.g.dart';

@JsonSerializable()
class ConversationStep {
  final String prompt;
  final String input;

  ConversationStep({required this.input, required this.prompt});

  factory ConversationStep.fromJson(Map<String, dynamic> json) =>
      _$ConversationStepFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationStepToJson(this);
}
