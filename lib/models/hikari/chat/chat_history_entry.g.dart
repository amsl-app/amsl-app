// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatHistoryEntry _$ChatHistoryEntryFromJson(Map<String, dynamic> json) =>
    ChatHistoryEntry(
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
      direction: $enumDecode(_$DirectionEnumMap, json['direction']),
    );

Map<String, dynamic> _$ChatHistoryEntryToJson(ChatHistoryEntry instance) =>
    <String, dynamic>{
      'client': instance.client,
      'payload': instance.payload,
      'direction': _$DirectionEnumMap[instance.direction]!,
    };

const _$DirectionEnumMap = {
  Direction.send: 'SEND',
  Direction.receive: 'RECEIVE',
};
