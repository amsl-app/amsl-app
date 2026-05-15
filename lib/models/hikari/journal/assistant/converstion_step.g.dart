// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'converstion_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationStep _$ConversationStepFromJson(Map<String, dynamic> json) =>
    ConversationStep(
      input: json['input'] as String,
      prompt: json['prompt'] as String,
    );

Map<String, dynamic> _$ConversationStepToJson(ConversationStep instance) =>
    <String, dynamic>{'prompt': instance.prompt, 'input': instance.input};
