// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionSource _$SessionSourceFromJson(Map<String, dynamic> json) =>
    SessionSource(
      fileName: json['file_name'] as String,
      fileId: json['file_id'] as String,
    );

Map<String, dynamic> _$SessionSourceToJson(SessionSource instance) =>
    <String, dynamic>{
      'file_name': instance.fileName,
      'file_id': instance.fileId,
    };
