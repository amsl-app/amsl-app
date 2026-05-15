import 'package:amsl_app/features/journal/models/moods.dart';
import 'package:amsl_app/themes/chat_theme.dart';
import 'package:flutter/material.dart';

class MoodBubble extends StatelessWidget {
  const MoodBubble(this.mood, this.sentByMe, {super.key});

  final double mood;
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).chatTheme;
    final theme = sentByMe ? chatTheme.ownBubbles : chatTheme.otherBubbles;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: theme.backgroundColor,
          ),
          child: Icon(
            Moods.get(mood).data.icon,
            size: 40,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
