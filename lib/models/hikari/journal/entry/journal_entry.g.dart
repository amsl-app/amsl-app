// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) => JournalEntry(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  title: json['title'] as String?,
  mood: (json['mood'] as num?)?.toDouble(),
  created: DateTime.parse(json['created_at'] as String),
  updated: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$JournalEntryToJson(JournalEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.created.toIso8601String(),
      'updated_at': instance.updated.toIso8601String(),
      'title': instance.title,
      'mood': instance.mood,
    };
