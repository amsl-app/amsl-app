import 'package:amsl_app/features/chat/models/duration_message.dart';
import 'package:amsl_app/features/chat/models/focus_message.dart';
import 'package:amsl_app/features/chat/models/image_message.dart';
import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/models/mood_message.dart';
import 'package:amsl_app/features/chat/models/text_chunk.dart';
import 'package:amsl_app/features/chat/models/text_message.dart';
import 'package:amsl_app/features/chat/repository/chat.dart';
import 'package:amsl_app/features/chat/repository/chat_stream.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/widgets/elements/bubble.dart';
import 'package:amsl_app/features/chat/widgets/elements/image_message.dart'
    as image_message_widget;
import 'package:amsl_app/features/chat/widgets/elements/scroll_methods.dart';
import 'package:amsl_app/features/chat/widgets/elements/typing_bubble.dart';
import 'package:amsl_app/features/journal/widgets/focus/chat_focus_bubble.dart';
import 'package:amsl_app/features/journal/widgets/mood/chat_mood_bubble.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../elements/duration_bubble.dart';

class ChatHistory extends StatefulHookConsumerWidget {
  static final log = Logger("ChatHistory");

  ChatHistory({
    super.key,
    required this.scrollController,
    required Session session,
  }) : channel = ChatChannel.fromSession(session);

  final ScrollController scrollController;
  final ChatChannel channel;

  @override
  ConsumerState<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends ConsumerState<ChatHistory> {
  bool _showScrollDownButton = false;
  late ScrollController _scrollController;

  void scrollCallback() {
    setState(() {
      _showScrollDownButton =
          (_scrollController.offset > _scrollController.initialScrollOffset)
          ? true
          : false;
    });
  }

  @override
  void initState() {
    _scrollController = widget.scrollController..addListener(scrollCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatStream = ref.watch(chatStreamProvider(widget.channel));
    final chatState = ref.watch(chatProvider(widget.channel));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO Do we want to persist scroll positions between screen switches?
      if (_scrollController.offset > _scrollController.initialScrollOffset !=
          _showScrollDownButton) {
        // Scroll button hide/show is not accurate anymore probably because we switched sessions -> fix it
        setState(() {
          _showScrollDownButton =
              (_scrollController.offset > _scrollController.initialScrollOffset)
              ? true
              : false;
          ChatHistory.log.info(
            "Scroll button not in sync - updated to $_showScrollDownButton",
          );
        });
      }
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: chatStream.build(
                  context,
                  builder: (context, chatMessages) {
                    var count = chatMessages!.length;

                    final typing = chatState.typing;
                    if (typing) count += 1;

                    return ListView.separated(
                      padding: MediaQuery.of(
                        context,
                      ).padding.copyWith(bottom: 0),
                      controller: _scrollController,
                      reverse: true,
                      itemCount: count + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const Gap(8);
                        }
                        index -= 1;
                        if (index == count) {
                          return const Gap(8);
                        }
                        int lastIndex = (count - 1);
                        int currentIndex = lastIndex - index;

                        late Widget message;
                        late Sender sender;
                        late bool showIcon;
                        late bool showEdge;

                        if (typing && currentIndex == lastIndex) {
                          message = const TypingBubble();
                          sender = Sender.other;
                          showIcon = true;
                          showEdge = false;
                        } else {
                          Message chatMessage = chatMessages[currentIndex];
                          message = buildMessage(chatMessage, context);
                          sender = chatMessage.sender;

                          //not typing
                          if (currentIndex == lastIndex) {
                            showIcon = showEdge = true;
                          } else if ((currentIndex == lastIndex - 1) &&
                              typing) {
                            showIcon = false;
                            showEdge = true;
                          } else if (chatMessages[currentIndex + 1].sender !=
                              chatMessages[currentIndex].sender) {
                            showIcon = showEdge = true;
                          } else {
                            showIcon = showEdge = false;
                          }

                          if (sender == Sender.self) showIcon = false;
                        }
                        return buildChatBubble(
                          message: message,
                          sender: sender,
                          showIcon: showIcon,
                          showEdge: showEdge,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(8);
                      },
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return ListView(children: [Container()]);
                  },
                  loadingBuilder: (context) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: 1,
                      itemBuilder: (context, index) => buildChatBubble(
                        message: const TypingBubble(),
                        sender: Sender.other,
                        showIcon: true,
                        showEdge: false,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        buildScrollDownButton(context),
      ],
    );
  }

  Widget buildScrollDownButton(BuildContext context) {
    return Visibility(
      visible: _showScrollDownButton,
      child: Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton.small(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.onSurface,
            size: 28,
          ),
          onPressed: () {
            scrollToBottom(_scrollController);
          },
        ),
      ),
    );
  }

  Widget buildTextMessage(Sender sender, String text) {
    return Bubble(text, sender == Sender.self);
  }

  Widget buildFocusMessage(FocusMessage step) =>
      FocusBubble(step.focusIDs, step.sender == Sender.self);

  Widget buildMoodMessage(MoodMessage step) =>
      MoodBubble(step.mood, step.sender == Sender.self);

  Widget buildDurationMessage(DurationMessage step) => DurationBubble(
    duration: step.duration,
    sentByMe: step.sender == Sender.self,
  );

  // Widget buildCard(csml_card.Card card, ChatController chatController) {
  //   return CardRepresentation(
  //       imageUrl: card.imageUri.toString(),
  //       title: card.title,
  //       button: CardButton(
  //           // TODO support more than one button
  //           onButtonPressed: () {
  //             chatController
  //                 .sendTextMessage((card.buttons.first as Button).payload);
  //           },
  //           title: (card.buttons.first as Button).text));
  // }

  Widget buildMessage(dynamic step, BuildContext context) {
    switch (step) {
      case TextMessage _:
        return buildTextMessage(step.sender, step.text);
      case TextChunk _:
        return buildTextMessage(step.sender, step.content);
      case ImageMessage _:
        return image_message_widget.ImageMessage(uri: step.uri);
      case FocusMessage _:
        return buildFocusMessage(step);
      case MoodMessage _:
        return buildMoodMessage(step);
      case DurationMessage _:
        return buildDurationMessage(step);
      default:
        final message = "Unknown step type: ${step.runtimeType}";
        ChatHistory.log.severe(message);
        return Bubble(message, false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollCallback);
    super.dispose();
  }
}
