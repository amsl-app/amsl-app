import 'package:json_annotation/json_annotation.dart';

import 'direction.dart';
import 'payload.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message({
    required this.payload,
    this.messageId,
    this.direction = Direction.send,
    this.sequence,
  });

  String? messageId;
  Payload payload;
  Direction direction;
  int? sequence;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return "HikariMessage { payload: $payload, direction: $direction }";
  }
}
