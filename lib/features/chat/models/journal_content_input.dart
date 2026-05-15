import 'package:amsl_app/features/chat/models/message.dart';

class JournalContentInput extends Message {
  final String? prompt;
  final bool? requireAssistant;

  const JournalContentInput({
    required this.prompt,
    required this.requireAssistant,
  }) : super(sender: Sender.other);
}
