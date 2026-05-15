import 'package:amsl_app/features/chat/models/message.dart';

class ConversationError extends Message {
  final String message;
  final int statusCode;

  const ConversationError({required this.message, required this.statusCode})
    : super(sender: Sender.other);
}
