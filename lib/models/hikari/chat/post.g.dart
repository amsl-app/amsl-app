// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  conversationEnd: json['conversation_end'] as bool,
  createdEntities: (json['created_entities'] as List<dynamic>?)
      ?.map((e) => CreatedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  messages: (json['messages'] as List<dynamic>)
      .map((e) => Message.fromJson(e as Map<String, dynamic>))
      .toList(),
  history: json['history'] as bool? ?? false,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'conversation_end': instance.conversationEnd,
  'messages': instance.messages,
  'history': instance.history,
  'created_entities': instance.createdEntities,
};
