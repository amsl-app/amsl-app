import 'package:amsl_app/features/chat/models/message.dart';

class NumberInput extends Message {
  final int? placeholder;
  final int? min;
  final int? max;

  NumberInput({required super.sender, this.max, this.min, this.placeholder});
}
