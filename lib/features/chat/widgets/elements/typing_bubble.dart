import 'package:amsl_app/themes/chat_theme.dart';
import 'package:flutter/material.dart';

import 'typing_indicator.dart';

class TypingBubble extends StatelessWidget {
  const TypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return TypingIndicator(
      bubbleColor: Theme.of(context).chatTheme.otherBubbles.backgroundColor,
    );
  }
}
