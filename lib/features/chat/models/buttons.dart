import 'message.dart';

class Button {
  final String text;
  final String? _payload;
  final Confirm? confirm;
  final Function()? onPressed;
  final bool skipDefaultAction;

  Button({
    required this.text,
    String? payload,
    this.onPressed,
    this.confirm,
    this.skipDefaultAction = false,
  }) : _payload = payload;

  String get payload {
    return _payload ?? text;
  }
}

class Buttons extends Message {
  final List<Button> buttons;
  final bool isQuickReply;

  Buttons({required this.buttons, super.onPressed, required this.isQuickReply})
    : super(sender: Sender.other);
}

enum Confirm { chatgpt }
