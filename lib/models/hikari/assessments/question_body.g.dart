// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiChoice _$MultiChoiceFromJson(Map<String, dynamic> json) => MultiChoice(
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$MultiChoiceToJson(MultiChoice instance) =>
    <String, dynamic>{'options': instance.options};

LikertScale _$LikertScaleFromJson(Map<String, dynamic> json) => LikertScale(
  max: (json['max'] as num).toInt(),
  min: (json['min'] as num).toInt(),
  hintMax: json['hint_max'] as String?,
  hintMin: json['hint_min'] as String?,
);

Map<String, dynamic> _$LikertScaleToJson(LikertScale instance) =>
    <String, dynamic>{
      'hint_max': instance.hintMax,
      'hint_min': instance.hintMin,
      'max': instance.max,
      'min': instance.min,
    };

TextField _$TextFieldFromJson(Map<String, dynamic> json) =>
    TextField(placeholder: json['placeholder'] as String);

Map<String, dynamic> _$TextFieldToJson(TextField instance) => <String, dynamic>{
  'placeholder': instance.placeholder,
};

TextArea _$TextAreaFromJson(Map<String, dynamic> json) =>
    TextArea(placeholder: json['placeholder'] as String);

Map<String, dynamic> _$TextAreaToJson(TextArea instance) => <String, dynamic>{
  'placeholder': instance.placeholder,
};

Select _$SelectFromJson(Map<String, dynamic> json) =>
    Select(yes: json['yes'] as String?, no: json['no'] as String?);

Map<String, dynamic> _$SelectToJson(Select instance) => <String, dynamic>{
  'yes': instance.yes,
  'no': instance.no,
};

SingleChoice _$SingleChoiceFromJson(Map<String, dynamic> json) =>
    SingleChoice();

Map<String, dynamic> _$SingleChoiceToJson(SingleChoice instance) =>
    <String, dynamic>{};
