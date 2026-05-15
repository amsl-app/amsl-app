import 'package:json_annotation/json_annotation.dart';

import 'button.dart';
import 'card/card.dart';

part 'payload_content.g.dart';

@JsonSerializable()
class PayloadContent {
  PayloadContent({
    this.title,
    this.type,
    this.displayType,
    this.buttons,
    this.payload,
    this.text,
    this.duration,
    this.buttonType,
    this.url,
    this.imageUrl,
    this.cards,
    this.error,
    this.placeholder_text,
  });

  String? title;
  String? type;
  @JsonKey(name: "display-type")
  String? displayType;
  List<Button>? buttons;
  dynamic payload;
  String? text;
  int? duration;
  @JsonKey(name: "button_type")
  String? buttonType;
  String? url;
  @JsonKey(name: "image_url")
  String? imageUrl;
  List<Card>? cards;
  String? error;
  String? placeholder_text;

  factory PayloadContent.fromJson(Map<String, dynamic> json) =>
      _$PayloadContentFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadContentToJson(this);

  @override
  String toString() {
    return "HikariPayload { title: $title, type: $type, displayType: $displayType, buttons: $buttons, payload: $payload, text: $text, duration: $duration, buttonType: $buttonType, url: $url, imageUrl: $imageUrl, cards: $cards, error: $error, placeholder_text: $placeholder_text }";
  }
}
