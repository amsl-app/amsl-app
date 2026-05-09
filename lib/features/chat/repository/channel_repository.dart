import 'dart:async';
import 'dart:collection';

import 'package:amsl_app/features/chat/models/buttons.dart';
import 'package:amsl_app/features/chat/models/chat_state.dart';
import 'package:amsl_app/features/chat/models/chat_step_entry.dart';
import 'package:amsl_app/features/chat/models/conversation_end.dart';
import 'package:amsl_app/features/chat/models/conversation_error.dart';
import 'package:amsl_app/features/chat/models/date_input.dart';
import 'package:amsl_app/features/chat/models/delay.dart';
import 'package:amsl_app/features/chat/models/duration_input.dart';
import 'package:amsl_app/features/chat/models/duration_message.dart';
import 'package:amsl_app/features/chat/models/focus_input.dart';
import 'package:amsl_app/features/chat/models/focus_message.dart';
import 'package:amsl_app/features/chat/models/hold.dart';
import 'package:amsl_app/features/chat/models/image_message.dart';
import 'package:amsl_app/features/chat/models/journal_content_input.dart';
import 'package:amsl_app/features/chat/models/journal_title_input.dart';
import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/models/mood_input.dart';
import 'package:amsl_app/features/chat/models/mood_message.dart';
import 'package:amsl_app/features/chat/models/number_input.dart';
import 'package:amsl_app/features/chat/models/text_chunk.dart';
import 'package:amsl_app/features/chat/models/text_message.dart';
import 'package:amsl_app/features/chat/repository/channel_source.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/repository/chat_repository.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/hikari/chat/post.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'channel_repository.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod, ChatChannelNotifier])
class ChatChannelRepositoryNotifier extends _$ChatChannelRepositoryNotifier {
  static final Logger log = Logger("ChatChannelRepositoryNotifier");
  final List<Message> _messages = [];
  final Queue<ChatStepEntry> queue = ListQueue(16);
  late StreamController<ChatState> controller;
  late ChatChannelSource chatSource;
  StreamSubscription<dynamic>? stepStoreSubscription;
  StreamSubscription<dynamic>? connectionSubscription;
  PausableTimer? _delay;

  bool reloading = false;
  bool initialized = false;

  @override
  CurrentChatState build({required ChatChannel channel}) {
    final source = ref.watch(chatChannelProvider(channel));

    log.finer("rebuilding channel repository for $channel");
    controller = StreamController.broadcast(
      onListen: () async {
        if (_delay != null && !_delay!.isExpired) {
          log.info(
            "resuming delay with remaining time: ${_delay!.duration - _delay!.elapsed}",
          );
        }
        _delay?.start();
        process(); // This also causes a event to be emitted
      },
      onCancel: () {
        if (_delay != null && !_delay!.isExpired) {
          log.info(
            "pausing delay with remaining time: ${_delay!.duration - _delay!.elapsed}",
          );
        }
        _delay?.pause();
      },
    );
    _subscribeToSource(source);
    return CurrentChatState();
  }

  List<Message>? get messages {
    if (initialized) {
      return _messages;
    }
    return null;
  }

  void _subscribeToSource(ChatChannelSource source) {
    chatSource = source;
    stepStoreSubscription?.cancel();
    connectionSubscription?.cancel();
    stepStoreSubscription = source.stream.listen(
      (data) {
        final (int sequence, List<ChatStepEntry> newMessages) = data;
        if (sequence == source.sequence) {
          initialized = true;
          queue.addAll(newMessages);
          process();
        } else {
          log.warning(
            "received data from outdated sequence $sequence. Current sequence is ${source.sequence}",
          );
        }
      },
      onError: (error, stacktrace) {
        log.info("Chat step error", error, stacktrace);
        controller.addError(error, stacktrace);
      },
    );
    connectionSubscription = source.connectionStateStream.listen((
      bool connected,
    ) {
      setConnectionState(isConnected: connected);
    });
  }

  Stream<ChatState> get stream {
    return controller.stream;
  }

  void setConversationEnd({required bool end}) {
    state = state.copyWith(
      isConversationEnd: end,
      hideInput: true,
      allowTextInput: false,
    );
    clear();
  }

  void setConnectionState({required bool isConnected}) {
    state = state.copyWith(isConnected: isConnected);
    if (!isConnected) {
      resetInput();
    }
  }

  void setHideInput(bool hide) {
    state = state.copyWith(hideInput: hide);
  }

  void setReplyButtons({
    required Buttons? replyButtons,
    required bool hideInput,
  }) {
    state = state.copyWith(replyButtons: replyButtons, hideInput: hideInput);
  }

  void setNumberInput(NumberInput numberInput) {
    state = state.copyWith(numberInput: numberInput);
  }

  void setDateInput(DateInput dateInput) {
    state = state.copyWith(dateInput: dateInput);
  }

  void setJournalTitleInput(JournalTitleInput journalTitleInput) {
    state = state.copyWith(journalTitleInput: journalTitleInput);
  }

  void setJournalContentInput(JournalContentInput journalContentInput) {
    state = state.copyWith(journalContentInput: journalContentInput);
  }

  void setMoodInput(MoodInput moodInput) {
    state = state.copyWith(moodInput: moodInput);
  }

  void setFocusInput(FocusInput focusInput) {
    state = state.copyWith(focusInput: focusInput);
  }

  void setDurationInput(DurationInput durationInput) {
    state = state.copyWith(durationInput: durationInput);
  }

  void setAllowTextInput(bool allowTextInput) {
    state = state.copyWith(allowTextInput: allowTextInput);
  }

  void setTyping({required bool typing}) {
    state = state.copyWith(typing: typing);
  }

  void clear() {
    state = state.copyWith(
      dateInput: null,
      numberInput: null,
      moodInput: null,
      focusInput: null,
      journalTitleInput: null,
      journalContentInput: null,
      durationInput: null,
    );
  }

  void addChatMessages(Iterable<Message> messages) {
    _messages.addAll(messages);
    // Hide buttons if we add messages
    state = state.copyWith(replyButtons: null);
    controller.add(ChatState(state: state, messages: List.of(_messages)));
  }

  void upsertChunkMessages(TextChunk message) {
    HapticFeedback.lightImpact();
    // Find the message with the same id as the new message
    final existingChunkMessages = _messages.whereType<TextChunk>();

    var updateChunkMessage = existingChunkMessages.firstWhereOrNull(
      (m) => m.id == message.id,
    );

    if (updateChunkMessage == null) {
      // If no message with the same id is found, add the new message
      _messages.add(message);
    } else {
      // If a message with the same id is found, update its content
      updateChunkMessage.update(message.content);
    }

    // Hide buttons if we add messages
    state = state.copyWith(replyButtons: null);
    controller.add(ChatState(state: state, messages: List.of(_messages)));
  }

  Future<Post?> sendMessage({
    required dynamic data,
    required String contentType,
    required String payloadKey,
    String? journalType,
    String? displayType,
  }) async {
    clear();
    setHideInput(true);
    //setReplyButtons(replyButtons: null, hideInput: true);
    // Add chat message notifies listeners so we don't have to do it after setReplyButtons

    if (displayType == "duration") {
      addChatMessages([DurationMessage(duration: data, sender: Sender.self)]);
    } else if (journalType == "journal-focus") {
      addChatMessages([FocusMessage(focusIDs: data, sender: Sender.self)]);
    } else if (journalType == "journal-mood") {
      addChatMessages([MoodMessage(mood: data, sender: Sender.self)]);
    } else {
      addChatMessages([
        TextMessage(text: data.toString(), sender: Sender.self),
      ]);
    }

    try {
      return await chatSource.sendMessage(
        data,
        contentType: contentType,
        payloadKey: payloadKey,
        journalType: journalType,
        displayType: displayType,
      );
    } catch (e) {
      log.info("Failed to send message: $e");
      rethrow;
    }
  }

  // TODO: implement streaming function for messages
  void _processIteration() {
    final step = queue.removeFirst();

    if (state.isConversationEnd) {
      log.warning("Conversation ended before all messages were displayed");
      return;
    }

    log.fine("Processing ${step.step.runtimeType}");
    if (step.step.sender == Sender.self) {
      resetInput();
    }

    switch (step.step) {
      case Delay delay:
        final typing = delay.show;
        setAllowTextInput(false);
        setTyping(typing: typing);
        log.fine("Showing Delay for ${delay.delay}. Typing indicator: $typing");
        if (delay.delay != null) {
          _delay = PausableTimer(Duration(milliseconds: delay.delay!), () {
            log.fine("Continuing after ${delay.delay}");
            _delay = null;
            setTyping(typing: false);
            process();
          });
          _delay!.start();
        }
        // Return here to not run process twice
        return;
      case TextMessage _ ||
          DurationMessage _ ||
          FocusMessage _ ||
          MoodMessage _ ||
          ImageMessage _:
        setTyping(typing: false);
        addChatMessages([step.step]);
        break;
      case TextChunk chunk:
        upsertChunkMessages(chunk);
        break;
      case Buttons buttons:
        setReplyButtons(
          hideInput: !buttons.isQuickReply,
          replyButtons: buttons,
        );
        break;
      case NumberInput numberInput:
        setNumberInput(numberInput);
        break;
      case DateInput dateInput:
        setDateInput(dateInput);
        break;
      case JournalTitleInput journalTitleInput:
        setJournalTitleInput(journalTitleInput);
        break;
      case JournalContentInput journalContentInput:
        setJournalContentInput(journalContentInput);
        break;
      case FocusInput focusInput:
        setFocusInput(focusInput);
        break;
      case MoodInput moodInput:
        setMoodInput(moodInput);
        break;
      case DurationInput durationInput:
        setDurationInput(durationInput);
        break;
      case ConversationEnd _:
        log.info("Ending conversation");
        setConversationEnd(end: true);
        setTyping(typing: false);
        return;
      case ConversationError error:
        log.warning("Setting error: ${error.message}");
        setError(ChatError(message: error.message));
        setTyping(typing: false);
        return;
      case Hold _:
        log.info("Holding");
        setTyping(typing: false);
        if (state.replyButtons == null &&
            state.numberInput == null &&
            state.dateInput == null &&
            state.durationInput == null &&
            state.moodInput == null &&
            state.focusInput == null) {
          setAllowTextInput(true);
        }
        setHideInput(false);
        break;
      default:
        log.severe("Unknown type: ${step.step.runtimeType}");
        break;
    }
  }

  void process() {
    if (_delay != null && _delay!.isExpired) {
      _delay = null;
    }
    while (queue.isNotEmpty && _delay == null) {
      _processIteration();
    }
    // When we are done with processing publish the current chat state
    log.info("Emitting state $state");
    controller.add(ChatState(state: state, messages: _messages));
  }

  void setError(ChatError error) {
    state = state.copyWith(error: error, resolvingError: false);
    controller.add(ChatState(state: state, messages: _messages));
  }

  void setResolving({bool resolving = true}) {
    state = state.copyWith(resolvingError: resolving);
    controller.add(ChatState(state: state, messages: _messages));
  }

  void clearError() {
    state = state.copyWith(error: null, resolvingError: false);
    controller.add(ChatState(state: state, messages: _messages));
  }

  Future<void> reload() async {
    if (state.resolvingError) {
      // Already resolving an error -> do nothing
      return;
    }

    // Set the error to resolving to show users we are working on it
    setResolving();

    // To reload the chat we:
    // 1. Get new messages
    // 2. Clear the store
    try {
      final List<ChatStepEntry>? steps;
      // Get new messages
      switch (chatSource) {
        case ChannelChatStepStream source:
          await source.reload();
          steps = [];
          break;
        case ChannelChatStepStore source:
          steps = await source.initialize(
            moduleId: source.moduleId,
            sessionId: source.sessionId,
          );
      }
      // Clear the old messages and replace them with the new messages
      clearMessages(steps);
      // Process will send out the current state so we don't have to do it
      process();
    } catch (e, stacktrace) {
      log.warning("Failed to reload chat", e, stacktrace);
      rethrow;
    } finally {
      setResolving(resolving: false);
    }
  }

  void reset(CurrentChatState state) {
    // Clear everything
    initialized = false;
    _messages.clear();
    _delay?.cancel();
    _delay = null;
    queue.clear();
    controller.add(ChatState(state: state, messages: _messages));
  }

  Future<void> abort() async {
    try {
      log.fine("aborting");
      initialized = false;
      state = CurrentChatState();
      _messages.clear();
      _delay?.cancel();
      _delay = null;
      queue.clear();
      controller.add(ChatState(state: state, messages: _messages));
      await chatSource.abort();
    } catch (e) {
      log.warning("Failed to abort chat", e);
      rethrow;
    }
  }

  Future<void> reconnect() async {
    try {
      final steps = await chatSource.reconnect();
      if (steps != null) {
        clearMessages(steps);
        process();
      }
    } catch (e) {
      log.warning("Failed to reconnect chat", e);
      rethrow;
    }
  }

  Future<void> restart({bool acceptRunning = false}) async {
    try {
      // To reload the chat we create a new chat state
      final List<ChatStepEntry>? steps;
      try {
        switch (chatSource) {
          case ChannelChatStepStream source:
            await source.restart();
            steps = [];
            break;
          case ChannelChatStepStore source:
            steps = await source.restart(
              moduleId: source.moduleId,
              sessionId: source.sessionId,
            ); // Need to manually initialize because we have to wait for the first message
        }
      } on HikariClientException catch (e) {
        // TODO kind of hacky but should work for now
        if (e.statusCode == 409 && acceptRunning) {
          log.info("chat is already running - not restarting");
          return;
        }
        rethrow;
      }
      clearMessages(steps);

      // Process will send out the current state so we don't have to do it
      process();
    } catch (e, stacktrace) {
      log.warning("Failed to restart chat", e, stacktrace);
      rethrow;
    } finally {
      setResolving(resolving: false);
    }
  }

  void clearMessages(List<ChatStepEntry>? steps) {
    state = CurrentChatState();
    reset(state);
    // This adds the steps to the store which will then re-emit them, triggering the normal processes
    chatSource.reinitialize(steps);
  }

  void resetInput() {
    state = state.copyWith(hideInput: true, allowTextInput: false);
    clear();
  }

  void close() {
    initialized = false;
    _delay?.cancel();
    _delay = null;
    queue.clear();
    chatSource.close();
  }
}
