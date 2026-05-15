import 'package:json_annotation/json_annotation.dart';

import '../card/card.dart';

part 'carousel_content.g.dart';

@JsonSerializable()
class CarouselContent {
  final List<Card> cards;

  CarouselContent({required this.cards});

  factory CarouselContent.fromJson(Map<String, dynamic> json) =>
      _$CarouselContentFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselContentToJson(this);
}
