// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadContent _$PayloadContentFromJson(Map<String, dynamic> json) =>
    PayloadContent(
      title: json['title'] as String?,
      type: json['type'] as String?,
      displayType: json['display-type'] as String?,
      buttons: (json['buttons'] as List<dynamic>?)
          ?.map((e) => Button.fromJson(e as Map<String, dynamic>))
          .toList(),
      payload: json['payload'],
      text: json['text'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      buttonType: json['button_type'] as String?,
      url: json['url'] as String?,
      imageUrl: json['image_url'] as String?,
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
      placeholder_text: json['placeholder_text'] as String?,
    );

Map<String, dynamic> _$PayloadContentToJson(PayloadContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'display-type': instance.displayType,
      'buttons': instance.buttons,
      'payload': instance.payload,
      'text': instance.text,
      'duration': instance.duration,
      'button_type': instance.buttonType,
      'url': instance.url,
      'image_url': instance.imageUrl,
      'cards': instance.cards,
      'error': instance.error,
      'placeholder_text': instance.placeholder_text,
    };
