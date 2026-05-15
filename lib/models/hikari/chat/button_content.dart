import 'package:json_annotation/json_annotation.dart';

part 'button_content.g.dart';

@JsonSerializable()
class ButtonContent {
  final String? payload;
  final String title;
  final String? confirm;
  final List<dynamic>? accepts;

  ButtonContent({
    required this.accepts,
    required this.payload,
    required this.title,
    this.confirm,
  });

  factory ButtonContent.fromJson(Map<String, dynamic> json) =>
      _$ButtonContentFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonContentToJson(this);
}
