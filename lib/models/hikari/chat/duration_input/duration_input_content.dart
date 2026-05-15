import 'package:json_annotation/json_annotation.dart';

part 'duration_input_content.g.dart';

@JsonSerializable()
class DurationInputContent {
  final String? title;
  final String? placeholder;
  final num? step;
  @JsonKey(name: "default")
  final num? defaultValue;
  final num? min;
  final num? max;

  DurationInputContent({
    this.title,
    this.min,
    this.max,
    this.placeholder,
    this.step,
    this.defaultValue,
  });

  factory DurationInputContent.fromJson(Map<String, dynamic> json) =>
      _$DurationInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$DurationInputContentToJson(this);
}
