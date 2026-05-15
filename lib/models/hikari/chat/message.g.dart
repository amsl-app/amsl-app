// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
  messageId: json['messageId'] as String?,
  direction:
      $enumDecodeNullable(_$DirectionEnumMap, json['direction']) ??
      Direction.send,
  sequence: (json['sequence'] as num?)?.toInt(),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'messageId': instance.messageId,
  'payload': instance.payload,
  'direction': _$DirectionEnumMap[instance.direction]!,
  'sequence': instance.sequence,
};

const _$DirectionEnumMap = {
  Direction.send: 'SEND',
  Direction.receive: 'RECEIVE',
};
