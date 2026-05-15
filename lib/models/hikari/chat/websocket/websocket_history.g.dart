// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsocketHistory _$WebsocketHistoryFromJson(Map<String, dynamic> json) =>
    WebsocketHistory(
      messageOrder: (json['message_order'] as num).toInt(),
      message: Payload.fromJson(json['message'] as Map<String, dynamic>),
      direction: $enumDecode(_$DirectionEnumMap, json['direction']),
    );

Map<String, dynamic> _$WebsocketHistoryToJson(WebsocketHistory instance) =>
    <String, dynamic>{
      'message_order': instance.messageOrder,
      'message': instance.message,
      'direction': _$DirectionEnumMap[instance.direction]!,
    };

const _$DirectionEnumMap = {
  Direction.send: 'SEND',
  Direction.receive: 'RECEIVE',
};
