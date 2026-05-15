import 'dart:async';

import 'package:amsl_app/features/chat/models/chat_state.dart';
import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/repository/channel_repository.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/exception.dart';
import '../../../models/hikari/chat/post.dart';

part 'chat_repository.freezed.dart';
part 'chat_repository.g.dart';

@freezed
abstract class ChatState with _$ChatState {
  factory ChatState({
    required CurrentChatState state,
    required List<Message> messages,
  }) = _ChatState;
}

@Riverpod(dependencies: [ChatChannelRepositoryNotifier])
class ChatRepositoryNotifier extends _$ChatRepositoryNotifier {
  static final log = Logger("ChatRepositoryNotifier");

  @override
  ChatChannelRepositoryNotifier build(ChatChannel channel) {
    log.finer("rebuilding for $channel");
    return _getChannelRepository(channel);
  }

  ChatChannelRepositoryNotifier _getChannelRepository(ChatChannel channel) {
    return ref.watch(chatChannelRepositoryProvider(channel: channel).notifier);
  }

  Stream<List<Message>> getMessageStream(ChatChannel channel) {
    log.info("Creating message stream for $channel");
    late StreamController<List<Message>> controller;
    StreamSubscription<ChatState>? channelSubscription;
    controller = StreamController.broadcast(
      onListen: () async {
        channelSubscription = _getChannelRepository(channel).stream.listen(
          (event) {
            controller.add(event.messages);
          },
          onError: (error, stacktrace) {
            // State stream handles error
          },
        );
      },
      onCancel: () {
        channelSubscription?.cancel();
      },
    );
    return controller.stream;
  }

  Stream<CurrentChatState> getStateStream(ChatChannel channel) {
    log.info(
      "Creating chat state stream for channel ${channel.sessionId} in Module ${channel.moduleId}",
    );
    late StreamController<CurrentChatState> controller;
    StreamSubscription<ChatState>? channelSubscription;
    controller = StreamController.broadcast(
      onListen: () async {
        channelSubscription = _getChannelRepository(channel).stream.listen(
          (event) {
            controller.add(event.state);
          },
          onError: (error, stacktrace) {
            final ChatError chatError;

            if (error is HikariStatusException) {
              chatError = ChatError(
                message: error.message,
                statusCode: error.statusCode,
              );
            } else {
              chatError = ChatError(message: error.toString());
            }
            setError(channel, chatError);
            throw error;
          },
        );
      },
      onCancel: () {
        channelSubscription?.cancel();
      },
    );

    return controller.stream;
  }

  Future<Post?> sendTextMessage(ChatChannel channel, String message) async {
    final repository = _getChannelRepository(channel);
    try {
      return await repository.sendMessage(
        data: message,
        contentType: "text",
        payloadKey: "text",
      );
    } catch (e, stacktrace) {
      log.warning("Failed to send message", e, stacktrace);
      rethrow;
    }
  }

  Future<Post?> sendPayloadMessage(
    ChatChannel channel,
    dynamic payload,
    String? journalType,
    String? displayType,
  ) async {
    final repository = _getChannelRepository(channel);
    try {
      return await repository.sendMessage(
        data: payload,
        contentType: "payload",
        payloadKey: "payload",
        journalType: journalType,
        displayType: displayType,
      );
    } catch (e, stacktrace) {
      log.warning("Failed to send message", e, stacktrace);
      rethrow;
    }
  }

  CurrentChatState getState(ChatChannel channel) {
    return _getChannelRepository(channel).state;
  }

  List<Message> getMessages(ChatChannel channel) {
    return _getChannelRepository(channel).messages ?? [];
  }

  ChatChannelRepositoryNotifier getStateRepository(ChatChannel channel) {
    return _getChannelRepository(channel);
  }

  void clearError(ChatChannel channel) {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      repository.clearError();
    }
  }

  void setError(ChatChannel channel, ChatError error) {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      repository.setTyping(typing: false);
      repository.setError(error);
    }
  }

  Future<void> reload(ChatChannel channel) async {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      await repository.reload();
    }
  }

  Future<void> maybeReload(ChatChannel channel) async {
    final repository = _getChannelRepository(channel);
    if (repository.state.hasError) {
      log.info("Reloading chat because of error");
      await repository.reload();
    }
  }

  Future<void> restart(ChatChannel channel) async {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      await repository.restart();
    }
  }

  Future<void> reconnect(ChatChannel channel) async {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      await repository.reconnect();
    }
  }

  Future<void> abort(ChatChannel channel) async {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      await repository.abort();
    }
  }

  void close(ChatChannel channel) {
    final repository = _getChannelRepository(channel);
    if (ref.mounted) {
      repository.close();
    }
  }
}
