// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsocketConnectionInfo _$WebsocketConnectionInfoFromJson(
  Map<String, dynamic> json,
) => WebsocketConnectionInfo(
  history_needed: json['history_needed'] as bool,
  currentSequence: (json['current_sequence'] as num?)?.toInt(),
);

Map<String, dynamic> _$WebsocketConnectionInfoToJson(
  WebsocketConnectionInfo instance,
) => <String, dynamic>{
  'history_needed': instance.history_needed,
  'current_sequence': instance.currentSequence,
};
