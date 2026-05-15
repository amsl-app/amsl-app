// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carousel _$CarouselFromJson(Map<String, dynamic> json) => Carousel(
  content: CarouselContent.fromJson(json['content'] as Map<String, dynamic>),
  contentType: json['contentType'] as String? ?? "carousel",
);

Map<String, dynamic> _$CarouselToJson(Carousel instance) => <String, dynamic>{
  'content': instance.content,
  'contentType': instance.contentType,
};
