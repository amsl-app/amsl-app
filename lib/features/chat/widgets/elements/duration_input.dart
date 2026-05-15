import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/duration_input.dart';
import 'duration_bubble.dart';

class ChatDurationInput extends StatefulWidget {
  const ChatDurationInput(
    this.durationInput, {
    required this.onMessageSubmitted,
    this.focusNode,
    super.key,
  });

  final DurationInput durationInput;
  final Function(int) onMessageSubmitted;
  final FocusNode? focusNode;

  @override
  State<ChatDurationInput> createState() => _ChatNumberTextInputState();
}

class _ChatNumberTextInputState extends State<ChatDurationInput> {
  int minute = 0;
  int hour = 0;

  int secondsFromTime() {
    return ((hour * 60) + minute) * 60;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int? min = widget.durationInput.min;
    int? max = widget.durationInput.max;

    bool isValid() {
      int time = secondsFromTime();
      if (time == 0) return false;

      if (min != null && min > time) return false;
      if (max != null && max < time) return false;

      return true;
    }

    String hintText() {
      if (min != null && max != null) {
        return "Gebe eine Zeit zwischen ${stringFromSeconds(min)} und ${stringFromSeconds(max)} an";
      }

      if (min != null) {
        return "Gebe eine Zeit über ${stringFromSeconds(min)} an";
      }
      if (max != null) {
        return "Gebe eine Zeit unter ${stringFromSeconds(max)} an";
      }
      return "";
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        //  bottom: 16.0,
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  initialValue: "00",
                  maxLines: 1,
                  minLines: 1,
                  focusNode: widget.focusNode,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: hintText(),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() {
                    if (value.isEmpty) value = "0";
                    hour = int.parse(value);
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("h", style: theme.textTheme.titleMedium),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  initialValue: "00",
                  maxLines: 1,
                  minLines: 1,
                  focusNode: widget.focusNode,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: hintText(),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() {
                    if (value.isEmpty) value = "0";
                    minute = int.parse(value);
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("min", style: theme.textTheme.titleMedium),
            ),
            Visibility(
              visible: hour != 0 || minute != 0,
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
                        ? () => widget.onMessageSubmitted(secondsFromTime())
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
