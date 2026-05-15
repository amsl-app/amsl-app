// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'chat_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class ChatTheme extends ThemeExtension<ChatTheme> with _$ChatThemeTailorMixin {
  const ChatTheme({
    required this.ownBubbles,
    required this.otherBubbles,
    required this.buttons,
  });

  @override
  final BubbleTheme ownBubbles;
  @override
  final BubbleTheme otherBubbles;
  @override
  final TextButtonThemeData buttons;
}

@TailorMixinComponent()
class BubbleTheme extends ThemeExtension<BubbleTheme>
    with _$BubbleThemeTailorMixin {
  const BubbleTheme({required this.backgroundColor, required this.textStyle});

  @override
  final Color backgroundColor;
  @override
  final TextStyle textStyle;
}
