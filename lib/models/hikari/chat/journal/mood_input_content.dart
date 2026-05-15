import 'package:json_annotation/json_annotation.dart';

part 'mood_input_content.g.dart';

@JsonSerializable()
class MoodInputContent {
  final String prompt;

  MoodInputContent({required this.prompt});

  factory MoodInputContent.fromJson(Map<String, dynamic> json) =>
      _$MoodInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$MoodInputContentToJson(this);
}
