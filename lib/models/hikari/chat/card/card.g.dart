// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
  content: CardContent.fromJson(json['content'] as Map<String, dynamic>),
  contentType: json['content_type'] as String? ?? "card",
);

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
  'content': instance.content,
  'content_type': instance.contentType,
};
