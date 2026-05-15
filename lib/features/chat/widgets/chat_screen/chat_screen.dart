import 'package:amsl_app/features/chat/repository/chat.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/widgets/chat_screen/chat_back_layer.dart';
import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/legal/ai_warning.dart';
import 'package:amsl_app/features/modules/providers/session_provider.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:feedback_sentry/feedback_sentry.dart';
import '../../../../models/hikari/modules/module_category.dart';
import '../../../../models/hikari/modules/session.dart' as hikari_session;
import '../../../../models/tori/modules/module_configuration.dart';
import '../../../../widgets/error/error_bar.dart';
import '../../../journal/widgets/history/journal_history_popover.dart';
import '../../../modules/providers/module_configuration.dart';
import '../../../modules/providers/module_provider.dart';

import '../../repository/chat_controller.dart';
import 'chat_front_layer.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  static final log = Logger("ChatScreen");
  final String sessionID;
  final String moduleID;

  const ChatScreen({
    super.key,
    required this.sessionID,
    required this.moduleID,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late Session? _session;
  late ChatChannel? _channel;

  void cleanup() {
    final session = _session;
    final channel = _channel;
    if (channel == null || session == null) return;
    ref.read(chatControllerProvider.notifier).close(channel);

    final isConversationEnd = ref.read(chatProvider(channel)).isConversationEnd;

    if (isConversationEnd) {
      ref
          .read(moduleProvider.notifier)
          .setSessionStatusLocal(
            session,
            hikari_session.SessionStatus.finished,
          );
    }
    ref
        .read(moduleProvider.notifier)
        .reloadSingleModule(moduleID: widget.moduleID);

    if (session.module.target?.category == ModuleCategory.journal) {
      ref.read(journalProvider.notifier).reloadJournals();
    }
    if (session.module.target?.category == ModuleCategory.onboarding) {
      ref.read(userPodProvider.notifier).reloadUser();
    }
  }

  @override
  void initState() {
    ChatScreen.log.info(
      "init ChatScreen with sessionID: ${widget.sessionID} and moduleID: ${widget.moduleID}",
    );
    final session = ref.read(
      sessionPodProvider(widget.moduleID, widget.sessionID),
    );
    _session = session;

    if (session == null) {
      ChatScreen.log.severe(
        "Session not found for sessionID: ${widget.sessionID} and moduleID: ${widget.moduleID}",
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          showMessage(context, label: "Session nicht gefunden", error: true);
          context.pop();
        }
      });
    } else {
      _channel = ChatChannel.fromSession(session);
      if (session.isLlm) {
        checkApproval(
          context,
          ref.read(storagesProvider).shared,
          key: StorageKey.acceptOpenAIChat.key,
          bottomBar: true,
        );
      }
      ref
          .read(moduleProvider.notifier)
          .setSessionStatusLocal(
            _session!,
            hikari_session.SessionStatus.started,
          );
      ref.read(chatControllerProvider.notifier).reconnect(_channel!);

      if (_session!.module.target?.category == ModuleCategory.journal &&
          _session!.status == hikari_session.SessionStatus.finished) {
        ref.read(chatControllerProvider.notifier).restart(_channel!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatScreen.log.info("Creating chat screen");
    final session = _session;

    final baseTheme = Theme.of(context);
    final moduleTheme = session?.module.target?.theme ?? baseTheme.moduleTheme;

    ThemeData theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: baseTheme.colorScheme.onSecondary,
        displayColor: baseTheme.colorScheme.onSecondary,
      ),
      extensions: (Map<Object, ThemeExtension<dynamic>>.from(
        baseTheme.extensions,
      )..[moduleTheme.type] = moduleTheme).values,
    );

    if (session == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("Session nicht gefunden")),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (_, _) => cleanup(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Theme(
          data: theme,
          child: BackdropScaffold(
            stickyFrontLayer: true,
            backLayerBackgroundColor: moduleTheme.color,
            appBar: _buildAppBar(theme, session),
            frontLayer: ChatFrontLayer(session: session),
            backLayer: ChatBackLayer(session: session),
          ),
        ),
      ),
    );
  }

  Future _onClose({
    required Session session,
    required bool isConversationEnd,
    bool abort = false,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final channel = ChatChannel.fromSession(session);
    if (abort) {
      try {
        await ref.read(chatControllerProvider.notifier).abort(channel);
      } on Exception catch (e) {
        if (mounted) {
          showException(context, e);
          return;
        }
      }
    }
    if (mounted) {
      context.pop();
    }
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, Session? session) {
    final asyncModuleConfiguration = ref.watch(
      moduleConfigurationProviderProvider,
    );

    late final PreferredSizeWidget widget;

    asyncModuleConfiguration.handle(
      context,
      onData: (mc) {
        widget = _buildSuccess(
          session: session,
          moduleConfig: mc!,
          moduleTheme: theme.moduleTheme,
        );
      },
      onError: (error, _) {
        widget = _buildError(moduleTheme: theme.moduleTheme, error: error);
      },
      onLoading: () {
        widget = _buildLoading(moduleTheme: theme.moduleTheme);
      },
    );
    return widget;
  }

  PreferredSizeWidget _buildSuccess({
    required Session? session,
    required ModuleConfiguration moduleConfig,
    required ModuleTheme moduleTheme,
  }) {
    Widget? title;
    final baseTheme = Theme.of(context);

    final theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: baseTheme.colorScheme.onSecondary,
        displayColor: baseTheme.colorScheme.onSecondary,
      ),
    );

    Module? currentModule = session?.module.target;

    bool isJournal = currentModule?.category == ModuleCategory.journal;

    if (session == null || currentModule == null) {
      return BackdropAppBar(
        backgroundColor: theme.colorScheme.onSurface,
        automaticallyImplyLeading: false,
      );
    }
    final channel = ChatChannel.fromSession(session);

    title = Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => Backdrop.of(context).fling(),
                    child: CircularPercentIndicator(
                      progressColor: moduleTheme.progressBarTheme.color,
                      backgroundColor: moduleTheme.progressBarTheme.trackColor,
                      startAngle: 180.0,
                      percent:
                          (currentModule.doneCount) /
                          currentModule.sessions.length,
                      lineWidth: 3,
                      center: Icon(Icons.list, color: moduleTheme.textColor),
                      radius: 18.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentModule.title,
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(session.title, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                if (channel.stream)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          showAmslBottomSheet(
                            context: context,
                            content:
                                "Dieser Chat ist ein KI-Chat. Bitte beachte, dass diese Nachrichten von einer KI generiert werden und keine Garantie auf Richtigkeit besteht.\n\nGib keine persönlichen Informationen preis.",
                            onClose: () => Navigator.of(context).pop(),
                          );
                        },
                        child: Container(
                          color: moduleTheme.progressBarTheme.color,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            "KI-Chat",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );

    return BackdropAppBar(
      titleSpacing: 0,
      backgroundColor: moduleTheme.color,
      foregroundColor: moduleTheme.textColor,
      title: title,
      actions: [
        if (session.module.target!.category == ModuleCategory.journal)
          HookConsumer(
            builder: (context, ref, child) {
              final asyncJournal = ref.read(journalProvider);
              return asyncJournal.build(
                context,
                builder: (context, journalEntries) => Visibility(
                  visible: journalEntries!.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {
                      trackEvent(
                        category: TrackingCategory.journalInChatHistory,
                        action: TrackingAction.open,
                        name: session.id,
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            JournalHistoryPopover(journals: journalEntries),
                      );
                    },
                  ),
                ),
                loadingBuilder: (context) => Container(),
                errorBuilder: (context, error, stackTrace) => Container(),
              );
            },
          ),
        HookConsumer(
          builder: (context, ref, child) {
            final isConversationEnd = ref.watch(
              chatProvider(
                channel,
              ).select((chatState) => chatState.isConversationEnd),
            );

            return PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              color: theme.colorScheme.surfaceContainer,
              itemBuilder: (BuildContext context) => [
                if (!isConversationEnd)
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.close,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const Gap(8.0),
                        Text(
                          isJournal ? "Eintrag beenden" : "Einheit beenden",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await _onClose(
                        session: session,
                        isConversationEnd: false,
                        abort: true,
                      );
                    },
                  ),
                if (session.sources.isNotEmpty)
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.source,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const Gap(8.0),
                        Text(
                          "Quellen anzeigen",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      context.pushNamed(
                        "sources",
                        pathParameters: {
                          "moduleID": session.module.target!.id,
                          "sessionID": session.id,
                        },
                      );
                    },
                  ),
                PopupMenuItem(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.feedback,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(8.0),
                      Text(
                        "Feedback geben",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => BetterFeedback.of(context).show((
                    UserFeedback feedback,
                  ) async {
                    try {
                      final screen = GoRouter.of(
                        context,
                      ).routeInformationProvider.value.uri.pathSegments.last;
                      await sendFeedback(
                        screen,
                        feedback.text,
                        feedback.screenshot,
                      );
                      if (context.mounted) {
                        showMessage(
                          context,
                          label: "Feedback gesendet! Danke!",
                        );
                      }
                    } catch (e, s) {
                      ChatScreen.log.severe("Feedback error", e, s);
                      if (context.mounted) {
                        showMessage(
                          context,
                          label:
                              "Feedback konnte nicht gesendet werden! Versuche es später erneut.",
                        );
                      }
                    }
                  }),
                ),
              ],
            );
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _onClose(
            session: session,
            isConversationEnd: ref
                .watch(chatProvider(channel))
                .isConversationEnd,
          );
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      automaticallyImplyLeading: false,
    );
  }

  PreferredSizeWidget _buildLoading({required ModuleTheme moduleTheme}) {
    return BackdropAppBar(
      titleSpacing: 0,
      backgroundColor: moduleTheme.color,
      foregroundColor: moduleTheme.textColor,
      title: Align(
        alignment: Alignment.centerLeft,
        child: LoadingText(width: 200, color: moduleTheme.textColor),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          context.pop();
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      automaticallyImplyLeading: false,
    );
  }

  PreferredSizeWidget _buildError({
    required ModuleTheme moduleTheme,
    required Object error,
  }) {
    final baseTheme = Theme.of(context);
    final theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: baseTheme.colorScheme.onSecondary,
        displayColor: baseTheme.colorScheme.onSecondary,
      ),
    );

    return BackdropAppBar(
      titleSpacing: 0,
      backgroundColor: moduleTheme.color,
      foregroundColor: moduleTheme.textColor,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Fehler beim Laden: $error",
          style: theme.textTheme.titleSmall,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          context.pop();
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      automaticallyImplyLeading: false,
    );
  }
}
