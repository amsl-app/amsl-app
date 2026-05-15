// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselContent _$CarouselContentFromJson(Map<String, dynamic> json) =>
    CarouselContent(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarouselContentToJson(CarouselContent instance) =>
    <String, dynamic>{'cards': instance.cards};
