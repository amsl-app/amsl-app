import 'dart:async';

import 'package:amsl_app/features/chat/models/conversation_end.dart';
import 'package:amsl_app/features/chat/models/delay.dart';
import 'package:amsl_app/features/chat/models/hold.dart';
import 'package:amsl_app/features/chat/models/text_message.dart';
import 'package:amsl_app/features/chat/widgets/elements/bubble.dart';
import 'package:amsl_app/features/chat/widgets/elements/typing_bubble.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/models/hikari/journal/assistant/assistant_prompt.dart';
import 'package:amsl_app/models/hikari/journal/assistant/assistant_wordings.dart';
import 'package:amsl_app/models/hikari/journal/assistant/converstion_step.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:amsl_app/widgets/dialogs/closeable_dialog.dart';
import 'package:amsl_app/widgets/loading/loading_card.dart';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../../../hikari/hikari.dart';
import '../../../chat/models/message.dart';
import '../../../chat/widgets/elements/message_input.dart';

@Dependencies([HikariPod])
class ChatOverlay extends StatefulHookConsumerWidget {
  static final log = Logger("ChatOverlayState");

  final String initialInput;
  final Function(String, int) callback;
  final String firstPrompt;

  const ChatOverlay({
    super.key,
    required this.initialInput,
    required this.firstPrompt,
    required this.callback,
  });

  @override
  ConsumerState<ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends ConsumerState<ChatOverlay> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    trackEvent(
      category: TrackingCategory.journalAssist,
      action: TrackingAction.open,
      dimensions: {TrackingDimension.text: widget.firstPrompt},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final FocusNode inputNode = FocusNode();
    final TextEditingController textEditingController = TextEditingController();

    ChatOverlay.log.info(
      "Showing prompt chat for prompt \"${widget.firstPrompt}\"",
    );

    Hikari hikari = ref.read(hikariPodProvider);

    MessageStream messageStream = MessageStream(
      context,
      hikari: hikari,
      conversationSteps: [
        ConversationStep(
          input: widget.initialInput,
          prompt: widget.firstPrompt,
        ),
      ],
    );

    messageStream.startChat();

    return CloseableDialog(
      insetPadding: const EdgeInsets.all(10.0),
      outsidePadding: const EdgeInsets.all(10.0),
      backgroundColor: theme.colorScheme.surfaceContainer,
      child: StreamBuilder<List<Message>>(
        stream: messageStream.stream,
        builder: (context, snapshot) {
          bool showInput = false;
          if (snapshot.hasData) {
            List<Message> messages = snapshot.data!;
            if (scrollController.hasClients) {
              scrollController.jumpTo(
                scrollController.position.maxScrollExtent,
              );
            }
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: messages.mapIndexed((
                        int index,
                        Message message,
                      ) {
                        switch (message) {
                          case TextMessage _:
                            int lastIndex = (messages.length - 1);

                            bool showIcon = false;
                            bool showEdge = false;

                            if (index == lastIndex) {
                              //last message
                              showIcon = showEdge = true;
                            } else if (messages[index + 1].runtimeType !=
                                TextMessage) {
                              //last message before typing
                              showIcon = showEdge = true;
                            } else if (messages[index + 1].runtimeType ==
                                    TextMessage &&
                                messages[index + 1].sender != message.sender) {
                              //last message from Sender
                              showIcon = showEdge = true;
                            }
                            if (message.sender == Sender.self) {
                              showIcon = false;
                            }

                            return Column(
                              children: [
                                const Gap(10.0),
                                buildChatBubble(
                                  message: Bubble(
                                    message.text,
                                    message.sender == Sender.self,
                                    key: ValueKey(message),
                                    onPressed: message.onPressed,
                                    color: message.color,
                                    fontColor: message.fontColor,
                                  ),
                                  color: message.color,
                                  sender: message.sender,
                                  showIcon: showIcon,
                                  showEdge: showEdge,
                                ),
                              ],
                            );
                          case Delay _:
                            return const TypingBubble();
                          case Hold _:
                            showInput = true;
                            return const Gap(20.0);
                          case ConversationEnd _:
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Wähle eine Nachricht aus",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          default:
                            return Container();
                        }
                      }).toList(),
                    ),
                  ),
                  Visibility(
                    visible: showInput,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: MessageInput(
                        textEditingController: textEditingController,
                        onMessageSubmitted: (text) => messageStream.setText(
                          textEditingController.text,
                          widget.callback,
                        ),
                        onSendButtonPressed: () => messageStream.setText(
                          textEditingController.text,
                          widget.callback,
                        ),
                        allowInput: true,
                        focusNode: inputNode,
                      ),
                    ),
                  ),
                  const Gap(20.0),
                ],
              ),
            );
          }
          return const LoadingCard();
        },
      ),
      onClose: () => trackEvent(
        category: TrackingCategory.journalAssist,
        action: TrackingAction.close,
        name: "ChatOverlay",
      ),
    );
  }
}

class MessageStream {
  final BuildContext context;
  final List<Message> _messages = [];
  final StreamController<List<Message>> _streamController =
      StreamController<List<Message>>();

  late AssistantPrompt assistantPrompt;

  MessageStream(
    this.context, {
    required this.conversationSteps,
    required this.hikari,
  });

  final List<ConversationStep> conversationSteps;
  final Hikari hikari;

  Stream<List<Message>> get stream => _streamController.stream;

  Future _showDelay(Duration duration) async {
    addMessage(const Delay(show: true));
    await Future.delayed(duration);
    removeLastMessage();
  }

  void setError({Function()? onRetry}) {
    final theme = Theme.of(context);
    addMessage(
      TextMessage(
        color: theme.colorScheme.primary,
        fontColor: theme.colorScheme.onPrimary,
        text: "Es ist ein Fehler aufgetreten. Tippe um es erneut zu versuchen.",
        sender: Sender.other,
        onPressed: onRetry != null
            ? () {
                removeLastMessage();
                onRetry();
              }
            : null,
      ),
    );
  }

  void startChat() async {
    ChatOverlay.log.fine("Starting chat...");
    if (conversationSteps.isEmpty) return;
    addMessage(
      const TextMessage(
        text: "Hallo, ich helfe dir mit der Erstellung deines Journaleintrags.",
        sender: Sender.other,
      ),
    );
    addMessage(
      const TextMessage(
        text:
            "Ich werde dir eine Frage stellen und dir anschließend Formulierungen vorschlagen. Das kann einen kleinen Moment dauern",
        sender: Sender.other,
      ),
    );
    addAssistantPrompt();
  }

  Future addAssistantPrompt() async {
    addMessage(const Delay(show: true));
    try {
      assistantPrompt = await hikari.journalApi.getAssistantPrompt(
        step: conversationSteps.first,
      );
    } on Exception {
      removeLastMessage();
      setError(onRetry: addAssistantPrompt);
      return;
    }
    removeLastMessage();
    addMessage(
      TextMessage(text: assistantPrompt.summary, sender: Sender.other),
    );
    await _showDelay(const Duration(milliseconds: 500));
    addMessage(TextMessage(text: assistantPrompt.prompt, sender: Sender.other));
    addMessage(const Hold());
  }

  void setText(String text, Function(String, int) callback) {
    removeLastMessage();
    addMessage(TextMessage(text: text, sender: Sender.self));
    conversationSteps.add(
      ConversationStep(input: text, prompt: assistantPrompt.prompt),
    );
    addWordingOptions(callback);
  }

  Future addWordingOptions(Function(String, int) callback) async {
    addMessage(
      const TextMessage(
        text: "Was hältst du von dieser Formulierung?",
        sender: Sender.other,
      ),
    );
    await addWordingOptionsInner(callback);
  }

  Future addWordingOptionsInner(Function(String, int) callback) async {
    final theme = Theme.of(context);
    addMessage(const Delay(show: true));
    late AssistantWording wordings;
    try {
      wordings = await hikari.journalApi.getWordingAlternatives(
        steps: conversationSteps,
      );
    } on Exception {
      removeLastMessage();
      setError(onRetry: () => addWordingOptionsInner(callback));
      return;
    }
    removeLastMessage();

    for (int i = 0; i < wordings.alternatives.length; i++) {
      String wording = wordings.alternatives[i];
      trackEvent(
        category: TrackingCategory.journalAssist,
        action: TrackingAction.show,
        value: i,
        dimensions: {TrackingDimension.text: wording},
      );
      addMessage(
        TextMessage(
          text: wording,
          sender: Sender.other,
          color: theme.colorScheme.primary,
          fontColor: theme.colorScheme.onPrimary,
          onPressed: () {
            trackEvent(
              category: TrackingCategory.journalAssist,
              action: TrackingAction.choose,
              value: i,
              dimensions: {TrackingDimension.text: wording},
            );
            callback(wording, i);
            Navigator.pop(context);
          },
        ),
      );
      await _showDelay(const Duration(seconds: 1));
    }
    addMessage(
      TextMessage(
        text: "Meinen eigenen Text benutzen: ${conversationSteps.first.input}",
        sender: Sender.other,
        color: theme.colorScheme.primary.withValues(alpha: 0.5),
        fontColor: theme.colorScheme.onPrimary,
        onPressed: () {
          trackEvent(
            category: TrackingCategory.journalAssist,
            action: TrackingAction.choose,
            value: -1,
            dimensions: {TrackingDimension.text: conversationSteps.first.input},
          );
          Navigator.pop(context);
        },
      ),
    );

    addMessage(const ConversationEnd());
  }

  void addMessage(Message message) {
    _messages.add(message);
    _streamController.add(_messages);
  }

  void removeLastMessage() {
    _messages.removeLast();
    _streamController.add(_messages);
  }

  void dispose() {
    _streamController.close();
  }
}

//We have
