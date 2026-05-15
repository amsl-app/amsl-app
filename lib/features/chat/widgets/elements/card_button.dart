import 'package:amsl_app/themes/chat_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardButton extends StatefulWidget {
  CardButton({required this.onButtonPressed, required this.title, super.key});

  final VoidCallback onButtonPressed;
  final String title;
  var pressed = false;
  var enabled = true;

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(textButtonTheme: theme.chatTheme.buttons),
      child: TextButton(
        onPressed: () {
          if (widget.enabled) {
            widget.onButtonPressed();
            setState(() {
              widget.pressed = true;
              widget.enabled = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
