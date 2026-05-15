import 'package:json_annotation/json_annotation.dart';

import 'button_content.dart';

part 'button.g.dart';

@JsonSerializable()
class Button {
  Button({required this.content, required this.contentType});

  ButtonContent content;
  @JsonKey(name: "content_type")
  String? contentType;

  factory Button.fromJson(Map<String, dynamic> json) => _$ButtonFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}
