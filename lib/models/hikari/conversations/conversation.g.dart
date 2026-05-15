// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationInfo _$ConversationInfoFromJson(Map<String, dynamic> json) =>
    ConversationInfo(
      client: ClientInfo.fromJson(json['client'] as Map<String, dynamic>),
      flowId: json['flow_id'] as String,
      stepId: json['step_id'] as String,
      lastInteractionAt: json['last_interaction_at'] as String,
      created: json['created_at'] as String,
      updated: json['updated_at'] as String,
    );

Map<String, dynamic> _$ConversationInfoToJson(ConversationInfo instance) =>
    <String, dynamic>{
      'client': instance.client,
      'flow_id': instance.flowId,
      'step_id': instance.stepId,
      'last_interaction_at': instance.lastInteractionAt,
      'created_at': instance.created,
      'updated_at': instance.updated,
    };
