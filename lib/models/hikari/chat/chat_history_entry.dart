import 'package:amsl_app/models/hikari/chat/client.dart';
import 'package:amsl_app/models/hikari/chat/payload.dart';
import 'package:json_annotation/json_annotation.dart';

import 'direction.dart';

part 'chat_history_entry.g.dart';

@JsonSerializable()
class ChatHistoryEntry {
  ChatHistoryEntry({
    required this.client,
    required this.payload,
    required this.direction,
  });

  Client client;
  Payload payload;
  Direction direction;

  factory ChatHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ChatHistoryEntryToJson(this);
}
