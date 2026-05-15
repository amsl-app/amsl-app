// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_input_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberInputContent _$NumberInputContentFromJson(Map<String, dynamic> json) =>
    NumberInputContent(
      title: json['title'] as String,
      min: json['min'] as num?,
      max: json['max'] as num?,
      placeholder: json['placeholder'] as String?,
    );

Map<String, dynamic> _$NumberInputContentToJson(NumberInputContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'min': instance.min,
      'max': instance.max,
      'placeholder': instance.placeholder,
    };
