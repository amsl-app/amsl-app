import 'package:amsl_app/features/chat/models/message.dart';

class DurationInput extends Message {
  final String? placeholder;
  final int? defaultValue;
  final int? min;
  final int? max;
  final int? step;

  DurationInput({
    required super.sender,
    this.max,
    this.min,
    this.placeholder,
    this.defaultValue,
    this.step,
  });
}
