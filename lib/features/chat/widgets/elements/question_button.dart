import 'package:amsl_app/features/chat/models/buttons.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/themes/chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../legal/ai_warning.dart';
import 'package:amsl_app/features/preferences/storages.dart';

class QuestionButton extends HookConsumerWidget {
  const QuestionButton(
    this.title, {
    required this.notifyParent,
    required this.enabled,
    required this.pressed,
    this.confirm,
    super.key,
  });

  final String title;
  final Confirm? confirm;
  final bool enabled;
  final bool pressed;

  final Function() notifyParent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(textButtonTheme: theme.chatTheme.buttons),
      child: TextButton(
        onPressed: enabled
            ? () async {
                switch (confirm) {
                  case Confirm.chatgpt:
                    if (await checkApproval(
                      context,
                      ref.read(storagesProvider).shared,
                      key: StorageKey.acceptOpenAI.key,
                    )) {
                      notifyParent();
                    }
                    break;
                  case null:
                    notifyParent();
                }
              }
            : () {},
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
