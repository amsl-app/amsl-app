import 'message.dart';

class FocusMessage extends Message {
  final List<String> focusIDs;

  const FocusMessage({
    required this.focusIDs,
    required super.sender,
    super.onPressed,
  });
}
