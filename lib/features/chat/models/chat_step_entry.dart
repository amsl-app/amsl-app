import 'dart:collection';

import 'message.dart';

final class ChatStepEntry extends LinkedListEntry<ChatStepEntry> {
  final Message step;
  final int? sequence;

  ChatStepEntry(this.step, [this.sequence]);
}
