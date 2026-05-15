import 'dart:async';
import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/chat/repository/chat.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/widgets/elements/chat_buttons.dart';
import 'package:amsl_app/features/chat/widgets/elements/date_input.dart';
import 'package:amsl_app/features/chat/widgets/elements/duration_input.dart';
import 'package:amsl_app/features/chat/widgets/elements/message_input.dart';
import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../models/hikari/chat/post.dart';
import '../../../../models/hikari/modules/module_category.dart';
import '../../../../models/hikari/modules/session.dart' as hikari_session;
import '../../../../models/tori/modules/session.dart';
import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../journal/widgets/entry/chat_journal_input.dart';
import '../../../journal/widgets/focus/chat_focus_input.dart';
import '../../../journal/widgets/mood/chat_mood_input.dart';
import '../../../modules/providers/module_provider.dart';
import '../../models/chat_state.dart';
import '../../repository/chat_controller.dart';
import '../elements/number_input.dart';

class ChatInputOverlay extends HookConsumerWidget {
  static final log = Logger("ChatInputOverlay");

  final void Function() onSubmit;
  final double maxHeight;
  final Session session;
  final ChatChannel channel;

  ChatInputOverlay({
    super.key,
    required this.onSubmit,
    required this.maxHeight,
    required this.session,
  }) : channel = ChatChannel.fromSession(session);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final inputNode = useFocusNode();
    final keyboardVisibilityController = useMemoized(
      KeyboardVisibilityController.new,
    );

    useEffect(() {
      log.info(
        'keyboard visibility direct query: ${keyboardVisibilityController.isVisible}',
      );

      final keyboardSubscription = keyboardVisibilityController.onChange.listen(
        (bool visible) {
          log.info('keyboard visibility update. Is visible: $visible');
        },
      );

      return keyboardSubscription.cancel;
    }, [keyboardVisibilityController]);

    final controller = ref.read(chatControllerProvider.notifier);
    final chatState = ref.watch(chatProvider(channel));
    final theme = Theme.of(context);

    void handlePost(Post? post) {
      final created = post?.createdEntities?.isNotEmpty ?? false;

      log.fine("go to handlePost: $post");

      if (created) {
        log.fine("post handled successfully");
        ref.read(journalProvider.notifier).reloadJournals();
      }
    }

    Future<void> sendMessage(
      dynamic data, [
      String? journalType,
      String? displayType,
    ]) async {
      Post? post;
      textEditingController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
      onSubmit();

      if (journalType == null && displayType == null) {
        post = await controller.sendTextMessage(channel, data.toString());
      } else {
        post = await controller.sendPayloadMessage(
          channel,
          data,
          journalType,
          displayType,
        );
      }

      handlePost(post);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        boxShadow: chatState.hideInput
            ? []
            : [
                BoxShadow(
                  offset: const Offset(0, -4),
                  blurRadius: 6,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ],
      ),
      child: Column(
        children: [
          Visibility(
            visible:
                !chatState.hideInput &&
                !chatState.hasError &&
                chatState.isConnected,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///----------------------ButtonInput
                Visibility(
                  visible: chatState.replyButtons != null,
                  child: chatState.replyButtons != null
                      ? ChatButtons(
                          buttons: chatState.replyButtons!,
                          onPressed: (String payload) => sendMessage(
                            payload,
                            (chatState.hasJournalInput)
                                ? "journal-content"
                                : null,
                          ),
                        )
                      : const SizedBox(),
                ),

                ///----------------------NumberInput
                Visibility(
                  visible: chatState.numberInput != null,
                  child: chatState.numberInput != null
                      ? ChatNumberTextInput(
                          numberInput: chatState.numberInput!,
                          textEditingController: textEditingController,
                          onMessageSubmitted: (text) => sendMessage(
                            text,
                            (chatState.hasJournalInput)
                                ? "journal-content"
                                : null,
                          ),
                        )
                      : const SizedBox(),
                ),

                ///----------------------DateInput
                Visibility(
                  visible: chatState.dateInput != null,
                  child: chatState.dateInput != null
                      ? ChatDateInput(
                          chatState.dateInput!,
                          onDateSubmitted: (date) => sendMessage(
                            kOldDateFormat.format(date),
                            (chatState.hasJournalInput)
                                ? "journal-content"
                                : null,
                          ),
                        )
                      : const SizedBox(),
                ),

                ///----------------------DurationInput
                Visibility(
                  visible: chatState.durationInput != null,
                  child: chatState.durationInput != null
                      ? ChatDurationInput(
                          chatState.durationInput!,
                          onMessageSubmitted: (int duration) => sendMessage(
                            duration,
                            (chatState.hasJournalInput)
                                ? "journal-content"
                                : null,
                            "duration",
                          ),
                        )
                      : const SizedBox(),
                ),

                ///----------------------FocusInput
                Visibility(
                  visible: chatState.focusInput != null,
                  child: ChatFocusInput(
                    maxHeight: maxHeight,
                    onSubmit: (List<String> ids) =>
                        sendMessage(ids, "journal-focus"),
                  ),
                ),

                ///----------------------MoodInput
                Visibility(
                  visible: chatState.moodInput != null,
                  child: ChatMoodInput(
                    onSubmit: (double mood) =>
                        sendMessage(mood, "journal-mood"),
                  ),
                ),

                ///----------------------JournalInput
                Visibility(
                  visible:
                      chatState.allowTextInput &&
                      chatState.journalTitleInput != null,
                  child: MessageInput(
                    textEditingController: textEditingController,
                    onMessageSubmitted: (text) =>
                        sendMessage(text.trim(), "journal-title"),
                    onSendButtonPressed: () {
                      String text = textEditingController.text.trim();
                      sendMessage(text, "journal-title");
                    },
                    allowInput: chatState.allowTextInput,
                    focusNode: inputNode,
                    maxLines: 1,
                    hint: "Titel ...",
                  ),
                ),

                ///----------------------JournalInput
                Visibility(
                  visible:
                      chatState.allowTextInput &&
                      chatState.journalContentInput != null &&
                      chatState.journalTitleInput == null,
                  child:
                      chatState.journalContentInput != null &&
                          chatState.journalTitleInput == null
                      ? ChatJournalInput(
                          session: session,
                          requireAssistant:
                              chatState.journalContentInput!.requireAssistant ??
                              false,
                          textEditingController: textEditingController,
                          onMessageSubmitted: (text) =>
                              sendMessage(text.trim(), "journal-content"),
                          onSendButtonPressed: () {
                            String text = textEditingController.text.trim();
                            sendMessage(text, "journal-content");
                          },
                          allowInput: chatState.allowTextInput,
                          focusNode: inputNode,
                        )
                      : const SizedBox(),
                ),

                ///----------------------´TextInput
                Visibility(
                  visible:
                      chatState.allowTextInput &&
                      chatState.journalContentInput == null &&
                      chatState.journalTitleInput == null,
                  child: MessageInput(
                    textEditingController: textEditingController,
                    onMessageSubmitted: (text) => sendMessage(text.trim()),
                    onSendButtonPressed: () {
                      String text = textEditingController.text.trim();
                      sendMessage(text);
                    },
                    allowInput: chatState.allowTextInput,
                    focusNode: inputNode,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible:
                chatState.isConversationEnd &&
                !chatState.hasError &&
                chatState.isConnected,
            child: _buildEndCard(context, ref),
          ),
          Visibility(
            visible: chatState.hasError,
            child: _buildErrorCard(context, ref, chatState),
          ),
          Visibility(
            visible: !chatState.isConnected,
            child: _buildConnectionCard(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: colorScheme.primary,
          child: Ink(
            child: InkWell(
              onTap: () async {
                await ref
                    .read(chatControllerProvider.notifier)
                    .reconnect(channel);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi, color: colorScheme.onPrimary),
                      const Gap(5),
                      Expanded(
                        child: Text(
                          "Mit dem Assistenten verbinden",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(
    BuildContext context,
    WidgetRef ref,
    CurrentChatState chatState,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: colorScheme.primary,
          child: Ink(
            child: InkWell(
              onTap: () async {
                if (chatState.error!.abortModuleToResolve) {
                  ref
                      .read(moduleProvider.notifier)
                      .abortModule(moduleId: session.module.target!.id)
                      .handle(
                        context,
                        onData: (_) {
                          context.pop();
                        },
                      );
                } else if (chatState.error!.abortSessionToResolve) {
                  ref
                      .read(chatControllerProvider.notifier)
                      .abort(channel)
                      .handle(
                        context,
                        onData: (_) {
                          context.pop();
                        },
                      );
                } else {
                  await ref
                      .read(chatControllerProvider.notifier)
                      .reload(channel);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: (chatState.error != null)
                        ? [
                            Icon(
                              Icons.error_outline_sharp,
                              color: colorScheme.onPrimary,
                            ),
                            const Gap(5),
                            Expanded(
                              child: Text(
                                chatState.error!.abortModuleToResolve
                                    ? "Du hast bereits eine laufende Session. Hier drücken um sie abzubrechen und fortzufahren."
                                    : chatState.error!.abortSessionToResolve
                                    ? "Es ist ein Fehler aufgetreten.\n Hier drücken um die Einheit abzubrechen."
                                    : "Es ist ein Fehler aufgetreten.\n Hier drücken zum neu laden.",
                                style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEndCard(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: const Text("Fertig"),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: _getButtonRow(context, ref),
          ),
        ),
      ],
    );
  }

  List<Widget> _getButtonRow(BuildContext context, WidgetRef ref) {
    bool isOnboarding =
        session.module.target!.category == ModuleCategory.onboarding;
    bool is_journal = session.module.target!.category == ModuleCategory.journal;
    bool hasNextSession = session.next != null;
    bool show_restart_button_in_journal =
        ref.read(preferencesProvider).showRestartInCourse ?? false;

    //bool nextSessionLocked = hasNextSession && !session.next!.unlocked;

    if (isOnboarding) {
      if (hasNextSession) {
        return [
          _nextSessionButton(context),
          _repeatSessionButton(context, ref),
        ];
      }
      return [_startAppButton(context), _repeatSessionButton(context, ref)];
    }
    List<Widget> buttons = [];
    if (is_journal) {
      if (show_restart_button_in_journal) {
        buttons.add(_repeatSessionButton(context, ref));
      }
      buttons.add(_closeJournalSessionButton(context));
    } else {
      buttons.add(_repeatSessionButton(context, ref));
    }
    if (hasNextSession && session.next!.unlocked) {
      buttons.add(_nextSessionButton(context));
    }
    return buttons;
  }

  Widget _nextSessionButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Session nextSession = session.next!;
    bool unlocked = nextSession.unlocked;
    return RoundedCornerButton(
      buttonColor: colorScheme.primary,
      labelColor: colorScheme.onPrimary,
      onTap: () {
        if (unlocked) {
          context.replaceNamed(
            "chat",
            pathParameters: {
              "moduleId": session.next!.module.target!.id,
              "sessionId": session.next!.id,
            },
          );
        }
      },
      label: "Weiter zu ${session.next!.title}",
    );
  }

  Widget _repeatSessionButton(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return RoundedCornerButton(
      label: "Einheit wiederholen",
      onTap: () async {
        bool done = await ref
            .read(chatControllerProvider.notifier)
            .restart(channel);
        if (done) {
          ref
              .read(moduleProvider.notifier)
              .setSessionStatusLocal(
                session,
                hikari_session.SessionStatus.started,
              );
        }
      },
      buttonColor: colorScheme.surfaceContainer,
      borderColor: colorScheme.primary,
      labelColor: colorScheme.primary,
    );
  }

  Widget _closeJournalSessionButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RoundedCornerButton(
      label: "Zur Journalübersicht",
      onTap: () => context.pop(),

      buttonColor: colorScheme.surfaceContainer,
      borderColor: colorScheme.primary,
      labelColor: colorScheme.primary,
    );
  }

  Widget _startAppButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RoundedCornerButton(
      buttonColor: colorScheme.primary,
      labelColor: colorScheme.onPrimary,
      borderColor: colorScheme.onPrimary,
      onTap: () => context.pop(),
      label: "Lass uns starten",
    );
  }
}
