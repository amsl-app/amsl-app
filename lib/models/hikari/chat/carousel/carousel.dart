import 'package:json_annotation/json_annotation.dart';

import 'carousel_content.dart';

part 'carousel.g.dart';

@JsonSerializable()
class Carousel {
  Carousel({required this.content, this.contentType = "carousel"});

  final CarouselContent content;
  final String contentType;

  factory Carousel.fromJson(Map<String, dynamic> json) =>
      _$CarouselFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselToJson(this);
}
