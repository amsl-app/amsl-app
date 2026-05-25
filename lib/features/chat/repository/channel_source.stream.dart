part of 'channel_source.dart';

final class ChannelChatStepStream extends ChatChannelSource {
  static final log = Logger("ChannelChatStepStream");
  WebSocketChannel? channel;
  bool _isClosing = false;
  bool _isConnecting = false;
  StreamSubscription? _chatSubscription;
  late final StreamController<(int, List<ChatStepEntry>)> controller;
  late final StreamController<bool> connectionStateController;

  ChannelChatStepStream({
    required super.moduleId,
    required super.sessionId,
    required super.hikari,
  }) {
    log.info(
      "Creating ChannelChatStepStream for $sessionId in Module $moduleId",
    );
    controller = StreamController.broadcast(
      onListen: () async {
        await connectToWebsocket(true);
      },
    );

    connectionStateController = StreamController.broadcast();
  }

  @override
  Future close() async {
    _isClosing = true;
    await _chatSubscription?.cancel();
    _chatSubscription = null;
    await channel?.sink.close(status.normalClosure);
    channel = null;
    log.info(
      "Closed ChannelChatStepStream for $sessionId in Module $moduleId, closeCode: ${channel?.closeCode}",
    );
  }

  @override
  void reinitialize(List<ChatStepEntry>? steps) => sequence = sequence + 1;

  @override
  Stream get stream => controller.stream;

  @override
  Stream<bool> get connectionStateStream => connectionStateController.stream;

  Future reload() async {
    log.info("Closecode: ${channel?.closeCode}");
    if (channel != null && channel!.closeCode == null) {
      await close();
    }
    await connectToWebsocket(true);
  }

  @override
  Future<void> abort() async {
    log.fine("closing stream");
    reinitialize(null);
    await sendRequestToWebsocket(WebsocketRequest.abort());
    await close();
  }

  @override
  Future<List<ChatStepEntry>?> reconnect() async {
    await connectToWebsocket(false);
    return null;
  }

  Future connectToWebsocket(bool history_needed) async {
    if (_isConnecting) {
      log.info(
        "Already connecting to websocket for $sessionId in Module $moduleId - skipping",
      );
      return;
    }
    try {
      if (channel == null) {
        log.info(
          "Got first listener for $sessionId in Module $moduleId - connecting to websocket",
        );
      } else if (channel!.closeCode != null) {
        log.info(
          "Got listener for $sessionId in Module $moduleId - reconnecting to websocket",
        );
      } else {
        log.info(
          "Got listener for $sessionId in Module $moduleId - already connected to websocket",
        );
        return;
      }
      _isConnecting = true;
      channel = await initialize(moduleId: moduleId, sessionId: sessionId);
      _isConnecting = false;
      connectionStateController.add(true);
      await _chatSubscription?.cancel();
      _chatSubscription = hikari.moduleApi
          .streamChat(channel!)
          .listen(
            (response) {
              final steps = handlePost(response);
              steps.where((element) => element.sequence == sequence);
              if (controller.isClosed) {
                log.warning(
                  "Tried to listen to websocket for $sessionId in Module $moduleId, but controller is closed",
                );
                return;
              }
              controller.add((sequence, steps));
            },
            onError: (error, stacktrace) {
              if (controller.isClosed) {
                log.warning(
                  "Tried to listen to websocket for $sessionId in Module $moduleId, but controller is closed",
                );
                return;
              }
              if (error is HikariClosedWebsocketException) {
                connectionStateController.add(false);
                if (_isClosing) {
                  log.info(
                    "Websocket sucessfully closed for $sessionId in Module $moduleId",
                  );
                  _isClosing = false;
                } else {
                  log.warning(
                    "Websocket closed by server for $sessionId in Module $moduleId",
                  );
                  channel = null;
                }
                return;
              } else {
                controller.addError(error, stacktrace);
                log.severe("Error in websocket stream", error, stacktrace);
              }
            },
          );
      _sendConnectionInfo(history_needed);
    } on Exception catch (error, stacktrace) {
      _isConnecting = false;
      controller.addError(error, stacktrace);
      log.severe(
        "Failed to initialize websocket connection",
        error,
        stacktrace,
      );
    }
  }

  Future _sendConnectionInfo(bool history_needed) async {
    final request = WebsocketRequest.connectionInfo(history_needed, sequence);
    await sendRequestToWebsocket(request);
  }

  Future sendRequestToWebsocket(WebsocketRequest request) async {
    if (channel == null || channel!.closeCode != null) {
      await connectToWebsocket(false);
      reinitialize(null);
    }
    hikari.moduleApi.sendToChat(channel!, request);
    log.info("Sent message to $sessionId in Module $moduleId finished");
  }

  @override
  Future<Post?> sendMessage(
    dynamic data, {
    required String contentType,
    required String payloadKey,
    String? journalType,
    String? displayType,
  }) async {
    final payload = Payload(
      contentType: contentType,
      content: {
        payloadKey: data,
        "type": ?journalType,
        "display-type": ?displayType,
      },
    );
    await sendRequestToWebsocket(WebsocketRequest.chat(payload));
    return null; //is needed to fulfill the interface
  }

  Future restart() async => sendRequestToWebsocket(WebsocketRequest.restart());

  Future<WebSocketChannel> initialize({
    required String moduleId,
    required String sessionId,
  }) async {
    final channel = await hikari.moduleApi.connectToChat(moduleId, sessionId);
    log.info("Connected to websocket for $sessionId in Module $moduleId");
    return channel;
  }

  static List<ChatStepEntry> handlePost(
    WebsocketResponse response, {
    bool replay = false,
  }) {
    final List<ChatStepEntry> stepEntries = [];
    for (final msg in createMessageFromResponse(response)) {
      stepEntries.add(ChatStepEntry(msg));
    }
    return stepEntries;
  }

  static List<Message> createMessageFromResponse(
    WebsocketResponse response, {
    bool replay = false,
  }) {
    switch (response) {
      case WebsocketResponse(
        type: "chat",
        value: ChunkPost(:final id, :final content),
      ):
        return [TextChunk(content: content, id: id, sender: Sender.other)];
      case WebsocketResponse(
        type: "history",
        :final value as List<WebsocketHistory>,
      ):
        return value
            .map((e) {
              final sender = e.direction == Direction.receive
                  ? Sender.self
                  : Sender.other;
              return ChatChannelSource.createStepFromPayload(e.message, sender);
            })
            .flattened
            .toList();
      case WebsocketResponse(type: "conversation_end"):
        return [const ConversationEnd()];
      case WebsocketResponse(type: "hold"):
        return [const Hold()];
      case WebsocketResponse(type: "typing"):
        return [const Delay(show: true)];
      case WebsocketResponse(
        type: "error",
        value: WebsocketError(:final error, :final statusCode),
      ):
        return [ConversationError(message: error, statusCode: statusCode)];
      default:
        return [];
    }
  }
}
