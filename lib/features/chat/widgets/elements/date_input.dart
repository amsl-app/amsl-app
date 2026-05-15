import 'package:amsl_app/features/chat/models/date_input.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/buttons/rounded_button.dart';

class ChatDateInput extends StatefulWidget {
  final DateInput dateInput;
  final Function(DateTime) onDateSubmitted;

  const ChatDateInput(
    this.dateInput, {
    super.key,
    required this.onDateSubmitted,
  });

  @override
  State<ChatDateInput> createState() => _ChatDateInputState();
}

class _ChatDateInputState extends State<ChatDateInput> {
  @override
  Widget build(BuildContext context) {
    DateTime minDate = widget.dateInput.min != null
        ? DateTime.parse(widget.dateInput.min!)
        : DateTime(1900);
    DateTime maxDate = widget.dateInput.max != null
        ? DateTime.parse(widget.dateInput.max!)
        : DateTime(2100);

    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        //bottom: 16.0,
        top: 4.0,
      ),
      child: RoundedButton(
        label: "Tippe um ein Datum anzugben",
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: minDate,
            lastDate: maxDate,
          );
          if (date != null) widget.onDateSubmitted(date);
        },
      ),
    );
  }
}
