// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsocketError _$WebsocketErrorFromJson(Map<String, dynamic> json) =>
    WebsocketError(
      error: json['error'] as String,
      statusCode: (json['status_code'] as num).toInt(),
    );

Map<String, dynamic> _$WebsocketErrorToJson(WebsocketError instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status_code': instance.statusCode,
    };
