part of 'channel_source.dart';

/// Repository for raw messages of a single channel
class ChannelChatStepStore extends ChatChannelSource {
  static final log = Logger("ChannelChatStepStore");
  late final StreamController<(int, List<ChatStepEntry>)> controller;
  bool initialized = false;

  ChannelChatStepStore({
    required super.moduleId,
    required super.sessionId,
    required super.hikari,
  }) {
    controller = StreamController.broadcast(
      onListen: () async {
        if (!initialized) {
          final initializeSequence = sequence;
          log.info(
            "Got first listener for $sessionId in Module $moduleId - requesting data",
          );
          try {
            final steps = await initialize(
              moduleId: moduleId,
              sessionId: sessionId,
            );
            if (initializeSequence != sequence) {
              log.info(
                "Rejecting initialization from outdated sequence $initializeSequence. Current sequence is $sequence",
              );
              return;
            }
            initialized = true;
            controller.add((sequence, steps));
          } on Exception catch (error, stacktrace) {
            controller.sink.addError(error, stacktrace);
            controller.addError(error, stacktrace);
            log.severe("Failed to initialize store", error, stacktrace);
          }
        }
      },
      onCancel: () {},
    );
  }

  static List<ChatStepEntry> handlePost(Post post, {bool replay = false}) {
    // log.info("Decoded response: $post");

    final responseMessages = post.messages;
    final conversationEnd = post.conversationEnd;
    final List<ChatStepEntry> stepEntries = [];

    log.info("Got ${responseMessages.length} messages");

    for (var message in responseMessages) {
      final steps = createStepFromMessage(message, replay: replay);
      log.info("Adding ${steps.length} steps");
      stepEntries.addAll(
        steps.map((step) => ChatStepEntry(step, message.sequence)),
      );
      // notifyListeners();
    }
    if (conversationEnd) {
      stepEntries.add(ChatStepEntry(const ConversationEnd()));
    }
    // log.info("Decoded response: $post");
    if (!conversationEnd) {
      stepEntries.add(ChatStepEntry(const Hold()));
    }
    return stepEntries;
  }

  static List<Message> createStepFromMessage(
    hikari_message.Message message, {
    bool replay = false,
  }) {
    final payload = message.payload;
    final sender = message.direction == Direction.receive
        ? Sender.self
        : Sender.other;
    return ChatChannelSource.createStepFromPayload(
      payload,
      sender,
      replay: replay,
    );
  }

  @override
  void reinitialize(List<ChatStepEntry>? steps) {
    sequence = sequence + 1;
    if (steps != null) {
      controller.add((sequence, steps));
    }
  }

  @override
  void close() {
    initialized = false;
    sequence = sequence + 1;
  }

  @override
  Future<List<ChatStepEntry>?> reconnect() async {
    if (initialized) {
      return null;
    }
    final steps = await initialize(moduleId: moduleId, sessionId: sessionId);
    initialized = true;
    return steps;
  }

  @override
  Future<void> abort() async {
    close();
  }

  @override
  Future<Post> sendMessage(
    dynamic data, {
    required String contentType,
    required String payloadKey,
    List<Message>? history,
    String? journalType,
    String? displayType,
  }) async {
    final sendSequence = sequence;
    try {
      final post = await hikari.moduleApi.sendMessageToSession(
        moduleId: moduleId,
        sessionId: sessionId,
        data: data,
        contentType: contentType,
        payloadKey: payloadKey,
        journalType: journalType,
        displayType: displayType,
      );

      log.info(
        "Got ${post.messages.length} messages. History: ${post.history}",
      );
      if (sendSequence == sequence) {
        controller.add((sequence, handlePost(post, replay: post.history)));
      } else {
        log.info(
          "Rejecting messages from outdated sequence $sendSequence. Current sequence is $sequence",
        );
      }
      return post;
    } on Exception catch (e, stacktrace) {
      log.severe("Failed to send message", e, stacktrace);
      rethrow;
    }
  }

  @override
  Stream<(int, List<ChatStepEntry>)> get stream {
    return controller.stream;
  }

  @override
  Stream<bool> get connectionStateStream => Stream.value(true);

  Future<List<ChatStepEntry>> initialize({
    required String moduleId,
    required String sessionId,
  }) async {
    final post = await hikari.moduleApi.startModuleSession(
      moduleId: moduleId,
      sessionId: sessionId,
    );
    log.info(
      "Got ${post.messages.length} initial messages. History: ${post.history}",
    );

    return handlePost(post, replay: post.history);
  }

  Future<List<ChatStepEntry>> restart({
    required String moduleId,
    required String sessionId,
  }) async {
    final post = await hikari.moduleApi.resetModuleSession(
      moduleId: moduleId,
      sessionId: sessionId,
    );
    log.info(
      "Got ${post.messages.length} initial messages. History: ${post.history}",
    );
    return handlePost(post, replay: post.history);
  }
}
