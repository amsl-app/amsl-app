import 'package:json_annotation/json_annotation.dart';

import '../button.dart';

part 'card_content.g.dart';

@JsonSerializable()
class CardContent {
  final String title;
  final List<Button>? buttons;
  @JsonKey(name: "image_url")
  final Uri? imageUrl;

  CardContent({required this.title, this.buttons, this.imageUrl});

  factory CardContent.fromJson(Map<String, dynamic> json) =>
      _$CardContentFromJson(json);

  Map<String, dynamic> toJson() => _$CardContentToJson(this);
}
