import 'package:json_annotation/json_annotation.dart';

import 'client_info.dart';

part 'conversation.g.dart';

@JsonSerializable()
class ConversationInfo {
  ConversationInfo({
    required this.client,
    required this.flowId,
    required this.stepId,
    required this.lastInteractionAt,
    required this.created,
    required this.updated,
  });

  ClientInfo client;
  @JsonKey(name: "flow_id")
  String flowId;
  @JsonKey(name: "step_id")
  String stepId;
  @JsonKey(name: "last_interaction_at")
  String lastInteractionAt;
  @JsonKey(name: "created_at")
  String created;
  @JsonKey(name: "updated_at")
  String updated;

  factory ConversationInfo.fromJson(Map<String, dynamic> json) =>
      _$ConversationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationInfoToJson(this);
}
