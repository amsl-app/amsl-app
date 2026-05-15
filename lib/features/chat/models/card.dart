import 'message.dart';

class Card extends Message {
  final Uri imageUri;
  final String title;
  final dynamic defaultAction;
  final List<dynamic> buttons;

  Card({
    required this.imageUri,
    required this.title,
    this.defaultAction,
    required this.buttons,
    required super.sender,
  });
}
