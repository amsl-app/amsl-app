import 'package:flutter/material.dart';

import 'message.dart';

class TextChunk extends Message {
  String content;
  final int id;
  final bool isError;
  final Color? color;
  final Color? fontColor;

  void update(String newContent) {
    content = content + newContent;
  }

  TextChunk({
    required this.content,
    required this.id,
    this.isError = false,
    required super.sender,
    super.onPressed,
    this.color,
    this.fontColor,
  });
}
