import 'package:amsl_app/models/hikari/chat/payload.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../hikari/apis/hikari_module_api.dart';

part 'websocket_request.g.dart';

abstract class WebsocketRequestValue {
  Map<String, dynamic> toJson();
}

@JsonEnum(fieldRename: FieldRename.snake)
enum WebsocketRequestType { connectionInfo, chat, restart, abort }

class WebsocketRequest {
  WebsocketRequestType type;
  WebsocketRequestValue? value;

  WebsocketRequest({required this.type, required this.value});

  Map<String, dynamic> toJson() {
    switch (type) {
      case WebsocketRequestType.connectionInfo:
        return {"type": "connection_info", "value": value!.toJson()};
      case WebsocketRequestType.chat:
        return {"type": "chat", "value": value!.toJson()};
      case WebsocketRequestType.restart:
        return {"type": "restart"};
      case WebsocketRequestType.abort:
        return {"type": "abort"};
    }
  }

  factory WebsocketRequest.restart() {
    return WebsocketRequest(type: WebsocketRequestType.restart, value: null);
  }

  factory WebsocketRequest.abort() {
    return WebsocketRequest(type: WebsocketRequestType.abort, value: null);
  }

  factory WebsocketRequest.chat(Payload payload) {
    return WebsocketRequest(
      type: WebsocketRequestType.chat,
      value: WebsocketPayload(payload: payload, metadata: generateMetadata()),
    );
  }

  factory WebsocketRequest.connectionInfo(
    bool historyNeeded,
    int? currentSequence,
  ) {
    return WebsocketRequest(
      type: WebsocketRequestType.connectionInfo,
      value: WebsocketConnectionInfo(
        history_needed: historyNeeded,
        currentSequence: currentSequence,
      ),
    );
  }

  @override
  String toString() {
    return 'WebsocketRequest{type: $type, value: $value}';
  }
}

@JsonSerializable()
class WebsocketConnectionInfo implements WebsocketRequestValue {
  @JsonKey(name: "history_needed")
  bool history_needed;
  @JsonKey(name: "current_sequence")
  int? currentSequence;

  WebsocketConnectionInfo({required this.history_needed, this.currentSequence});

  factory WebsocketConnectionInfo.fromJson(Map<String, dynamic> json) =>
      _$WebsocketConnectionInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WebsocketConnectionInfoToJson(this);

  @override
  String toString() {
    return 'WebsocketConnectionInfo{historyNeeded: $history_needed, currentSequence: $currentSequence}';
  }
}

class WebsocketPayload implements WebsocketRequestValue {
  Payload payload;
  Map<String, dynamic> metadata;

  WebsocketPayload({required this.payload, required this.metadata});

  @override
  Map<String, dynamic> toJson() {
    return {"payload": payload.toJson(), "metadata": metadata};
  }
}
