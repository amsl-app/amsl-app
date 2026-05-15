import 'package:amsl_app/features/chat/models/message.dart';

class Hold extends Message {
  const Hold() : super(sender: Sender.other);
}
