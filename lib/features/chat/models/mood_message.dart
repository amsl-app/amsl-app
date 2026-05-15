import 'message.dart';

class MoodMessage extends Message {
  final double mood;

  const MoodMessage({
    required this.mood,
    required super.sender,
    super.onPressed,
  });
}
