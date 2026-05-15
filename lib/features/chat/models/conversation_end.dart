import 'package:amsl_app/features/chat/models/message.dart';

class ConversationEnd extends Message {
  const ConversationEnd() : super(sender: Sender.other);
}
