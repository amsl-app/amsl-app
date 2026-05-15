import 'dart:async';

import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../features/assessment/providers/assessment_sessions.dart';
import '../../features/journal/providers/journal.dart';
import '../../features/profile/providers/user_provider.dart';
import '../../hikari/exception.dart';

class MessageBarFrame extends StatefulWidget {
  const MessageBarFrame({super.key, required this.child});

  final Widget child;

  static void pushException(
    BuildContext context,
    Object exception, {
    List<(String, Function)>? functions,
  }) {
    context.findAncestorStateOfType<_MessageBarFrameState>()!.pushException(
      exception,
      functions: functions,
    );
  }

  static void pushMessage(
    BuildContext context,
    String message, {
    List<(String, Function)>? functions,
    bool error = false,
  }) {
    context.findAncestorStateOfType<_MessageBarFrameState>()!.pushMessage(
      message,
      functions: functions,
      error: error,
    );
  }

  @override
  State<MessageBarFrame> createState() => _MessageBarFrameState();
}

class _MessageBarFrameState extends State<MessageBarFrame> {
  void pushException(Object exception, {List<(String, Function)>? functions}) {
    if (exceptions[exception.hashCode] != null) {
      return;
    }
    setState(() {
      exceptions[exception.hashCode] = MessageBarException(
        exception,
        Timer(
          const Duration(milliseconds: 4000),
          () => setState(() => exceptions.remove(exception.hashCode)),
        ),
        functions: functions,
      );
    });
  }

  void pushMessage(
    String message, {
    List<(String, Function)>? functions,
    bool error = false,
  }) {
    setState(() {
      exceptions[message.hashCode] = MessageBarException(
        message,
        Timer(
          const Duration(milliseconds: 4000),
          () => setState(() => exceptions.remove(message.hashCode)),
        ),
        error: error,
        functions: functions,
      );
    });
  }

  void removeException(Object exception) {
    exceptions[exception.hashCode]?.timer.cancel();
    setState(() {
      exceptions.remove(exception.hashCode);
    });
  }

  Map<int, MessageBarException> exceptions = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Builder(
          builder: (context) {
            return widget.child;
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: getBottomBarPadding(context) * 1.5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(exceptions.length, (index) {
                  final messageBarException = exceptions.values.elementAt(
                    index,
                  );
                  final isError = messageBarException.error;

                  final object = messageBarException.object;
                  // get the error type
                  switch (object) {
                    case HikariClientException(
                      :final statusCode,
                      :final message,
                      :final resolve,
                    ):
                      return MessageBar(
                        label: "Es gab ein Problem bei der Anfrage",
                        resolve: resolve,
                        statusCode: statusCode,
                        message: message,
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                    case HikariServerException(
                      :final statusCode,
                      :final message,
                      :final resolve,
                    ):
                      return MessageBar(
                        label:
                            "Es konnte keine Verbindung zum Sever hergestellt werden.",
                        resolve: resolve,
                        statusCode: statusCode,
                        message: message,
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                    case HikariUnauthorizedException(
                      :final message,
                      :final resolve,
                    ):
                      return MessageBar(
                        label: "Du wurdest ausgeloogt.",
                        message: message,
                        resolve: resolve,
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                    case HikariNetworkException(:final message, :final resolve):
                      return MessageBar(
                        label:
                            "Es gibt ein Problem mit der Netzwerkverbindung.",
                        message: message,
                        resolve: resolve,
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                    case String():
                      return MessageBar(
                        label: object,
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                    default:
                      return MessageBar(
                        label: "Das hat nicht funktioniert. Starte die App neu",
                        error: isError,
                        functions: messageBarException.functions,
                        close: () => removeException(object),
                      );
                  }
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageBar extends StatelessWidget {
  const MessageBar({
    super.key,
    required this.label,
    required this.close,
    required this.error,
    this.message,
    this.resolve,
    this.statusCode,
    this.functions,
  });

  final bool error;
  final int? statusCode;
  final String? message;
  final String label;
  final Function? resolve;
  final Function close;
  final List<(String, Function)>? functions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: error
                  ? theme.colorScheme.onError
                  : theme.colorScheme.primary,
              width: 4,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/avatar_images/avatar.svg",
                    height: 25,
                  ),
                  const Gap(20),
                  Expanded(
                    child: Text(
                      label,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: error
                            ? theme.colorScheme.onError
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  if (functions == null)
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: error
                            ? theme.colorScheme.onError
                            : theme.colorScheme.primary,
                      ),
                      onPressed: () => close(),
                    ),
                ],
              ),
              if ((statusCode != null || message != null) && kDebugMode)
                const Gap(10),
              if (statusCode != null && kDebugMode)
                Text(
                  "Status Code: $statusCode",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: error
                        ? theme.colorScheme.onError
                        : theme.colorScheme.primary,
                  ),
                ),
              if (message != null && kDebugMode)
                Text(
                  message ?? "",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: error
                        ? theme.colorScheme.onError
                        : theme.colorScheme.primary,
                  ),
                ),
              if (resolve != null)
                TextButton(
                  child: Text(
                    "Nochmal versuchen",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: error
                          ? theme.colorScheme.onError
                          : theme.colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    close();
                    resolve!();
                  },
                ),
              if (functions != null)
                ...functions!.map((e) {
                  return TextButton(
                    child: Text(
                      e.$1,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: error
                            ? theme.colorScheme.onError
                            : theme.colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      close();
                      e.$2();
                    },
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}

void showMessage(
  BuildContext context, {
  String? label,
  bool error = false,
  List<(String, Function)>? functions,
}) {
  if (label == null && !error) {
    throw ArgumentError("Label must be provided if error is false");
  }

  String label0 = label ?? (error ? "Es ist ein Fehler aufgetreten" : "");

  WidgetsBinding.instance.addPostFrameCallback((_) {
    MessageBarFrame.pushMessage(
      context,
      label0,
      error: error,
      functions: functions,
    );
  });
}

void showException(
  BuildContext context,
  Object exception, {
  List<(String, Function)>? functions,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    MessageBarFrame.pushException(context, exception, functions: functions);
  });
}

Future<void> reloadAll(WidgetRef ref, BuildContext context) async {
  final userNotifier = ref.read(userPodProvider.notifier);
  final journalNotifier = ref.read(journalProvider.notifier);
  final assessmentNotifier = ref.read(assessmentSessionsProvider.notifier);
  final variantNotifier = ref.read(variantPodProvider.notifier);

  await userNotifier.reloadUser();
  await assessmentNotifier.reloadAssessmentSessions();
  await variantNotifier.reload();
  await journalNotifier.reloadJournals();
}

class MessageBarException {
  final Object object;
  final Timer timer;
  final bool error;
  final List<(String, Function)>? functions;

  MessageBarException(
    this.object,
    this.timer, {
    this.functions,
    this.error = true,
  });
}
