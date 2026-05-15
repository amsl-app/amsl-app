import 'message.dart';

class Delay extends Message {
  final int? delay;
  final bool show;

  const Delay({this.delay, this.show = false}) : super(sender: Sender.other);
}
