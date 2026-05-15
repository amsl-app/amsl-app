// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_content_input_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalContentInputContent _$JournalContentInputContentFromJson(
  Map<String, dynamic> json,
) => JournalContentInputContent(
  prompt: json['prompt'] as String,
  requireAssistant: json['require_assistant'] as bool? ?? false,
);

Map<String, dynamic> _$JournalContentInputContentToJson(
  JournalContentInputContent instance,
) => <String, dynamic>{
  'prompt': instance.prompt,
  'require_assistant': instance.requireAssistant,
};
