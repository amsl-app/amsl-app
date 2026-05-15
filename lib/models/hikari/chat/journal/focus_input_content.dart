import 'package:json_annotation/json_annotation.dart';

part 'focus_input_content.g.dart';

@JsonSerializable()
class FocusInputContent {
  final String prompt;

  FocusInputContent({required this.prompt});

  factory FocusInputContent.fromJson(Map<String, dynamic> json) =>
      _$FocusInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$FocusInputContentToJson(this);
}
