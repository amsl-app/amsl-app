// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Button _$ButtonFromJson(Map<String, dynamic> json) => Button(
  content: ButtonContent.fromJson(json['content'] as Map<String, dynamic>),
  contentType: json['content_type'] as String?,
);

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
  'content': instance.content,
  'content_type': instance.contentType,
};
