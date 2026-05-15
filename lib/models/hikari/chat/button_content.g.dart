// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonContent _$ButtonContentFromJson(Map<String, dynamic> json) =>
    ButtonContent(
      accepts: json['accepts'] as List<dynamic>?,
      payload: json['payload'] as String?,
      title: json['title'] as String,
      confirm: json['confirm'] as String?,
    );

Map<String, dynamic> _$ButtonContentToJson(ButtonContent instance) =>
    <String, dynamic>{
      'payload': instance.payload,
      'title': instance.title,
      'confirm': instance.confirm,
      'accepts': instance.accepts,
    };
