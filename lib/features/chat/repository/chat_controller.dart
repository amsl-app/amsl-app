import 'dart:async';

import 'package:amsl_app/features/chat/models/chat_state.dart';
import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/repository/channel_repository.dart';
import 'package:amsl_app/features/chat/repository/chat_repository.dart';
import 'package:amsl_app/features/modules/providers/module_provider.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/hikari/chat/post.dart';
import 'chat_channel.dart';

part 'chat_controller.g.dart';

class ChatController {}

@Riverpod(
  dependencies: [ChatRepositoryNotifier, ChatChannelNotifier, ModuleNotifier],
)
class ChatControllerNotifier extends _$ChatControllerNotifier {
  static final log = Logger("ChatControllerNotifier");

  @override
  ChatController build() {
    log.finer("rebuilding");
    return ChatController();
  }

  List<Message> getMessages(ChatChannel channel) {
    return ref
        .watch(chatRepositoryProvider(channel).notifier)
        .getMessages(channel);
  }

  Stream<List<Message>> chatStream(ChatChannel channel) {
    log.info("Creating chat stream for $channel");

    return ref
        .watch(chatRepositoryProvider(channel).notifier)
        .getMessageStream(channel);
  }

  Stream<CurrentChatState> stateStream(ChatChannel channel) {
    log.info(
      "Creating state stream for Session ${channel.sessionId} in Module ${channel.moduleId}",
    );
    return ref
        .watch(chatRepositoryProvider(channel).notifier)
        .getStateStream(channel);
  }

  CurrentChatState getState(ChatChannel channel) {
    log.info(
      "Getting state for Session ${channel.sessionId} in Module ${channel.moduleId}",
    );
    return ref
        .watch(chatRepositoryProvider(channel).notifier)
        .getState(channel);
  }

  ChatChannelRepositoryNotifier getChannelRepository(ChatChannel channel) {
    log.info(
      "Getting ref.watch(chatRepositoryProvider(channel).notifier) repository for Session ${channel.sessionId} in Module ${channel.moduleId}",
    );

    return ref
        .watch(chatRepositoryProvider(channel).notifier)
        .getStateRepository(channel);
  }

  Future<Post?> sendTextMessage(ChatChannel channel, String message) async {
    Post? post;
    try {
      post = await ref
          .watch(chatRepositoryProvider(channel).notifier)
          .sendTextMessage(channel, message);
      // When we are using websockets we need to reload the chatState because the messages triggered the reload already before we set the typing to false
    } catch (e, stacktrace) {
      log.warning("Could not send message", e, stacktrace);
      final ChatError chatError;

      if (e is HikariStatusException) {
        chatError = ChatError(message: e.message, statusCode: e.statusCode);
      } else {
        chatError = ChatError(message: e.toString());
      }
      ref
          .watch(chatRepositoryProvider(channel).notifier)
          .setError(channel, chatError);
    }

    return post;
  }

  Future<Post?> sendPayloadMessage(
    ChatChannel channel,
    dynamic payload,
    String? journalType,
    String? displayType,
  ) async {
    Post? post;
    try {
      post = await ref
          .watch(chatRepositoryProvider(channel).notifier)
          .sendPayloadMessage(channel, payload, journalType, displayType);
      // If we are using websockets we need to set the chatState manually because the messages triggered the the new ref.watch(chatRepositoryProvider(channel).notifier) already before we set the typing to false
    } catch (e, stacktrace) {
      log.warning("could not send message", e, stacktrace);
      final ChatError chatError;

      if (e is HikariStatusException) {
        chatError = ChatError(message: e.message, statusCode: e.statusCode);
      } else {
        chatError = ChatError(message: e.toString());
      }
      ref
          .watch(chatRepositoryProvider(channel).notifier)
          .setError(channel, chatError);
    }

    return post;
  }

  /*  def process_incoming_message(message):
    # Extract message ID and text chunk from the message
    message_id = message.message_id
    text_chunk = message.text_chunk

    # If the text chunk is null, finalize the message
    if text_chunk is None:
        return


    # Retrieve the current displayed content for the message ID
    current_content = get_displayed_content(message_id)

    # Append the new text chunk to the current content
    updated_content = current_content + text_chunk

    # Update the displayed content on the chat frontend
    display_message_on_chat_screen(message_id, updated_content)
 */

  void clearError(ChatChannel channel) {
    ref.watch(chatRepositoryProvider(channel).notifier).clearError(channel);
  }

  void setError(ChatChannel channel, ChatError error) {
    ref
        .watch(chatRepositoryProvider(channel).notifier)
        .setError(channel, error);
  }

  Future<void> reload(ChatChannel channel) async {
    try {
      await ref.watch(chatRepositoryProvider(channel).notifier).reload(channel);
    } catch (e, stacktrace) {
      log.warning("Failed to reload chat", e, stacktrace);
      // We ignore the error here
    }
  }

  Future<void> maybeReload(ChatChannel channel) async {
    try {
      await ref
          .watch(chatRepositoryProvider(channel).notifier)
          .maybeReload(channel);
    } catch (e, stacktrace) {
      log.warning("failed to reload chat", e, stacktrace);
    }
  }

  Future<bool> restart(ChatChannel channel) async {
    try {
      await ref
          .watch(chatRepositoryProvider(channel).notifier)
          .restart(channel);
      return true;
    } catch (e, stacktrace) {
      log.warning("failed to restart chat", e, stacktrace);
      return false;
    }
  }

  Future<void> reconnect(ChatChannel channel) async {
    try {
      await ref
          .watch(chatRepositoryProvider(channel).notifier)
          .reconnect(channel);
    } catch (e, stacktrace) {
      log.warning("failed to reconnect chat", e, stacktrace);
    }
  }

  void close(ChatChannel channel) {
    ref.watch(chatRepositoryProvider(channel).notifier).close(channel);
  }

  Future<void> abort(ChatChannel channel) async {
    log.fine("aborting $channel");
    await ref.watch(chatRepositoryProvider(channel).notifier).abort(channel);
    await ref
        .read(moduleProvider.notifier)
        .abortSession(moduleId: channel.moduleId, sessionId: channel.sessionId);
  }
}
