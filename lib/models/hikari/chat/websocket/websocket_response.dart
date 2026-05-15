import 'package:amsl_app/models/hikari/chat/websocket/websocket_history.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chunkpost.dart';

part 'websocket_response.g.dart';

class WebsocketResponse {
  final String type;
  final dynamic value;

  // TODO do we need sequence here?

  WebsocketResponse({required this.type, required this.value});

  static dynamic loadValue(String type, dynamic value) {
    switch (type) {
      case "chat":
        return ChunkPost.fromJson(value!);
      case "history":
        return (value! as List)
            .map((e) => WebsocketHistory.fromJson(e))
            .toList();
      case "error":
        return WebsocketError.fromJson(value!);
      default:
        return value;
    }
  }

  factory WebsocketResponse.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    return WebsocketResponse(
      type: type,
      value: WebsocketResponse.loadValue(type, json['value']),
    );
  }
}

@JsonSerializable()
class WebsocketError {
  final String error;
  @JsonKey(name: 'status_code')
  final int statusCode;

  WebsocketError({required this.error, required this.statusCode});

  factory WebsocketError.fromJson(Map<String, dynamic> json) =>
      _$WebsocketErrorFromJson(json);

  Map<String, dynamic> toJson() => _$WebsocketErrorToJson(this);
}
