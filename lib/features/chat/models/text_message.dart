import 'dart:ui';

import 'message.dart';

class TextMessage extends Message {
  final String text;
  final Color? color;
  final Color? fontColor;

  const TextMessage({
    required this.text,
    required super.sender,
    super.onPressed,
    this.color,
    this.fontColor,
  });
}
