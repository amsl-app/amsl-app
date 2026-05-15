// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_wordings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantWording _$AssistantWordingFromJson(Map<String, dynamic> json) =>
    AssistantWording(
      alternatives: (json['alternatives'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AssistantWordingToJson(AssistantWording instance) =>
    <String, dynamic>{'alternatives': instance.alternatives};
