import 'package:amsl_app/features/chat/models/number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class ChatNumberWheelInput extends StatefulWidget {
  final NumberInput numberInput;
  final Function(int) onNumberSubmitted;

  const ChatNumberWheelInput(
    this.numberInput, {
    super.key,
    required this.onNumberSubmitted,
  });

  @override
  State<ChatNumberWheelInput> createState() => _ChatNumberWheelInputState();
}

class _ChatNumberWheelInputState extends State<ChatNumberWheelInput> {
  int? value;

  @override
  Widget build(BuildContext context) {
    value ??= widget.numberInput.placeholder ?? widget.numberInput.min ?? 0;

    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        // bottom: 16.0,
        top: 4.0,
      ),
      child: numberInputRow(context),
    );
  }

  Widget numberInputRow(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 2),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [numberInput(context), sendButton(context)],
      ),
    );
  }

  Widget sendButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 20,
        child: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => widget.onNumberSubmitted(value!),
        ),
      ),
    );
  }

  Widget numberInput(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: NumberPicker(
        textStyle: theme.textTheme.bodyMedium!,
        selectedTextStyle: theme.textTheme.titleMedium!,
        haptics: true,
        axis: Axis.horizontal,
        minValue: widget.numberInput.min ?? 0,
        maxValue: widget.numberInput.max ?? 10000,
        value: value!,
        onChanged: (v) => setState(() {
          value = v;
        }),
      ),
    );
  }
}

class ChatNumberTextInput extends StatefulWidget {
  const ChatNumberTextInput({
    required this.numberInput,
    required this.textEditingController,
    required this.onMessageSubmitted,
    this.focusNode,
    super.key,
  });

  final NumberInput numberInput;
  final Function(String) onMessageSubmitted;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;

  @override
  State<ChatNumberTextInput> createState() => _ChatNumberTextInputState();
}

class _ChatNumberTextInputState extends State<ChatNumberTextInput> {
  String input = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int? min = widget.numberInput.min;
    int? max = widget.numberInput.max;

    bool isValid() {
      if (input.isEmpty) return false;

      if (min != null && min > int.parse(input)) return false;
      if (max != null && max < int.parse(input)) return false;

      return true;
    }

    String hintText() {
      if (min == null && max == null) return "Schreibe etwas...";
      if (min == null) return "Schreibe eine Zahl kleiner als $max";
      return "Schreibe eine Zahl zwischen $min und $max";
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        //bottom: 16.0,
        top: 4.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  minLines: 1,
                  controller: widget.textEditingController,
                  focusNode: widget.focusNode,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: hintText(),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() {
                    input = value;
                  }),
                  onSubmitted: ((value) =>
                      isValid() ? widget.onMessageSubmitted(input) : null),
                ),
              ),
            ),
            Visibility(
              visible: input.isNotEmpty,
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: isValid()
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.5),
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: isValid()
                        ? () => widget.onMessageSubmitted(input)
                        : () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
