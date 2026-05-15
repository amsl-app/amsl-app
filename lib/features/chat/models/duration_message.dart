import 'package:amsl_app/features/chat/models/message.dart';

class DurationMessage extends Message {
  final int duration;

  const DurationMessage({
    required this.duration,
    required super.sender,
    super.onPressed,
  });
}
