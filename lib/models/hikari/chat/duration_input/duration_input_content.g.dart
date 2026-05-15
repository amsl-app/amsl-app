// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_input_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationInputContent _$DurationInputContentFromJson(
  Map<String, dynamic> json,
) => DurationInputContent(
  title: json['title'] as String?,
  min: json['min'] as num?,
  max: json['max'] as num?,
  placeholder: json['placeholder'] as String?,
  step: json['step'] as num?,
  defaultValue: json['default'] as num?,
);

Map<String, dynamic> _$DurationInputContentToJson(
  DurationInputContent instance,
) => <String, dynamic>{
  'title': instance.title,
  'placeholder': instance.placeholder,
  'step': instance.step,
  'default': instance.defaultValue,
  'min': instance.min,
  'max': instance.max,
};
