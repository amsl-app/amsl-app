// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
  botId: json['botId'] as String?,
  channelId: json['channelId'] as String?,
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
  'botId': instance.botId,
  'channelId': instance.channelId,
  'userId': instance.userId,
};
