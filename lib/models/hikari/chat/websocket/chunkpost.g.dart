// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunkpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChunkPost _$ChunkPostFromJson(Map<String, dynamic> json) => ChunkPost(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$ChunkPostToJson(ChunkPost instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
};
