import 'package:amsl_app/features/chat/widgets/elements/question_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../models/buttons.dart';

class ChatButtons extends StatefulHookConsumerWidget {
  static final log = Logger("ChatButtons");
  final Buttons buttons;
  final Function(String payload) onPressed;

  const ChatButtons({
    super.key,
    required this.buttons,
    required this.onPressed,
  });

  @override
  ConsumerState<ChatButtons> createState() => _ChatButtonsState();
}

class _ChatButtonsState extends ConsumerState<ChatButtons> {
  static final log = Logger("ChatButtonsState");
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    log.fine("Building Chat buttons - Reading controllers");

    log.fine("Returning Question Buttons");

    return QuestionButtons(
      widget.buttons.buttons,
      enabled: enabled,
      isQuickReply: widget.buttons.isQuickReply,
      pressedButtonIndex: -1,
      onButtonPressed: (Button button) {
        if (!enabled) return false;
        setState(() {
          // We disable all buttons if any button is pressed
          enabled = false;
        });
        if (button.onPressed != null) {
          button.onPressed!();
        }
        if (!button.skipDefaultAction) {
          widget.onPressed(button.payload);
        }
      },
    );
  }
}
