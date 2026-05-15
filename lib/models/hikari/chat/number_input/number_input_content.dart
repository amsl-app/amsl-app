import 'package:json_annotation/json_annotation.dart';

part 'number_input_content.g.dart';

@JsonSerializable()
class NumberInputContent {
  final String title;
  final num? min;
  final num? max;
  final String? placeholder;

  NumberInputContent({
    required this.title,
    required this.min,
    required this.max,
    required this.placeholder,
  });

  factory NumberInputContent.fromJson(Map<String, dynamic> json) =>
      _$NumberInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$NumberInputContentToJson(this);
}
