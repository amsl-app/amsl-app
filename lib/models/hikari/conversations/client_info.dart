import 'package:json_annotation/json_annotation.dart';

part 'client_info.g.dart';

@JsonSerializable()
class ClientInfo {
  ClientInfo({
    required this.botId,
    required this.channelId,
    required this.userId,
  });

  @JsonKey(name: "bot_id")
  String botId;
  @JsonKey(name: "channel_id")
  String channelId;
  @JsonKey(name: "user_id")
  String userId;

  factory ClientInfo.fromJson(Map<String, dynamic> json) =>
      _$ClientInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ClientInfoToJson(this);
}
