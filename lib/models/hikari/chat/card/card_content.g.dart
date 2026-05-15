// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardContent _$CardContentFromJson(Map<String, dynamic> json) => CardContent(
  title: json['title'] as String,
  buttons: (json['buttons'] as List<dynamic>?)
      ?.map((e) => Button.fromJson(e as Map<String, dynamic>))
      .toList(),
  imageUrl: json['image_url'] == null
      ? null
      : Uri.parse(json['image_url'] as String),
);

Map<String, dynamic> _$CardContentToJson(CardContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'buttons': instance.buttons,
      'image_url': instance.imageUrl?.toString(),
    };
