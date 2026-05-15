// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientInfo _$ClientInfoFromJson(Map<String, dynamic> json) => ClientInfo(
  botId: json['bot_id'] as String,
  channelId: json['channel_id'] as String,
  userId: json['user_id'] as String,
);

Map<String, dynamic> _$ClientInfoToJson(ClientInfo instance) =>
    <String, dynamic>{
      'bot_id': instance.botId,
      'channel_id': instance.channelId,
      'user_id': instance.userId,
    };
