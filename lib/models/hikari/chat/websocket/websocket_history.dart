import 'package:amsl_app/models/hikari/chat/payload.dart';
import 'package:json_annotation/json_annotation.dart';

import '../direction.dart';

part 'websocket_history.g.dart';

@JsonSerializable()
class WebsocketHistory {
  @JsonKey(name: 'message_order')
  final int messageOrder;
  final Payload message;
  final Direction direction;

  WebsocketHistory({
    required this.messageOrder,
    required this.message,
    required this.direction,
  });

  factory WebsocketHistory.fromJson(Map<String, dynamic> json) =>
      _$WebsocketHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$WebsocketHistoryToJson(this);
}
