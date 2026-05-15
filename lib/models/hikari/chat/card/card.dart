import 'package:json_annotation/json_annotation.dart';

import 'card_content.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
  Card({required this.content, this.contentType = "card"});

  final CardContent content;
  @JsonKey(name: "content_type")
  final String contentType;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
