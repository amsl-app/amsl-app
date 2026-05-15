// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalContent _$JournalContentFromJson(Map<String, dynamic> json) =>
    _JournalContent(
      content: json['content'] as String?,
      title: json['title'] as String?,
      created: DateTime.parse(json['created_at'] as String),
      updated: DateTime.parse(json['updated_at'] as String),
      id: json['id'] as String,
      journalEntryId: json['journal_entry_id'] as String,
    );

Map<String, dynamic> _$JournalContentToJson(_JournalContent instance) =>
    <String, dynamic>{
      'content': instance.content,
      'title': instance.title,
      'created_at': instance.created.toIso8601String(),
      'updated_at': instance.updated.toIso8601String(),
      'id': instance.id,
      'journal_entry_id': instance.journalEntryId,
    };
