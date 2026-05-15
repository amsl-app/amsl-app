import 'package:amsl_app/features/chat/models/message.dart';

class DateInput extends Message {
  final String? min;
  final String? max;

  DateInput({required super.sender, this.min, this.max});
}
