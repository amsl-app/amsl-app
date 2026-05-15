import 'package:flutter/widgets.dart';

void scrollToBottom(ScrollController controller) {
  controller.animateTo(
    0.0,
    duration: const Duration(milliseconds: 400),
    curve: Curves.fastOutSlowIn,
  );
}
