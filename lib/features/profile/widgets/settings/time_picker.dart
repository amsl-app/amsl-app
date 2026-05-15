import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class TimePicker extends StatefulWidget {
  final String label;
  final Function onToggle;
  final Function onTimeChange;

  final TimeOfDay initTime;
  final bool initToggle;
  const TimePicker({
    super.key,
    required this.label,
    required this.onTimeChange,
    required this.onToggle,
    required this.initTime,
    required this.initToggle,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  bool? newToggle;
  TimeOfDay? newTime;

  @override
  Widget build(BuildContext context) {
    newTime ??= widget.initTime;
    newToggle ??= widget.initToggle;

    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(widget.label, style: theme.textTheme.titleSmall)),
        const Gap(12.0),
        InkWell(
          onTap: newToggle!
              ? () async {
                  final time = await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.inputOnly,
                    context: context,
                    initialTime: newTime!,
                  );

                  if (time != null) {
                    setState(() {
                      newTime = time;
                    });
                    widget.onTimeChange(time);
                  }
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: newToggle!
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${newTime!.hour.toString().padLeft(2, "0")} : ${newTime!.minute.toString().padLeft(2, "0")}",
              style: theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.primary.withValues(
                  alpha: newToggle! ? 1 : 0.2,
                ),
              ),
            ),
          ),
        ),
        const Gap(12.0),
        Switch(
          activeTrackColor: theme.colorScheme.primary,
          activeThumbColor: theme.colorScheme.onPrimary,
          inactiveTrackColor: theme.colorScheme.onPrimary,
          value: newToggle!,
          onChanged: (value) {
            setState(() {
              newToggle = value;
            });
            widget.onToggle(value);
          },
        ),
      ],
    );
  }
}

class TimeFrequencyPicker extends StatefulWidget {
  final String label;
  final Function onToggle;
  final Function onTimeChange;
  final Function onFrequencyChange;

  final TimeOfDay initTime;
  final bool initToggle;
  final int initFrequency;
  const TimeFrequencyPicker({
    super.key,
    required this.label,
    required this.onTimeChange,
    required this.onToggle,
    required this.onFrequencyChange,
    required this.initTime,
    required this.initToggle,
    required this.initFrequency,
  });

  @override
  State<TimeFrequencyPicker> createState() => _TimeFrequencyPickerState();
}

class _TimeFrequencyPickerState extends State<TimeFrequencyPicker> {
  bool? newToggle;
  TimeOfDay? newTime;
  int? newFrequency;

  @override
  Widget build(BuildContext context) {
    newTime ??= widget.initTime;
    newToggle ??= widget.initToggle;
    newFrequency ??= widget.initFrequency;

    final controller = TextEditingController(text: newFrequency.toString());

    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(widget.label, style: theme.textTheme.titleSmall),
            ),
            const Gap(12.0),
            Switch(
              activeTrackColor: theme.colorScheme.primary,
              activeThumbColor: theme.colorScheme.onPrimary,
              inactiveTrackColor: theme.colorScheme.onPrimary,
              value: newToggle!,
              onChanged: (value) {
                setState(() {
                  newToggle = value;
                });
                widget.onToggle(value);
              },
            ),
          ],
        ),
        const Gap(12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nach",
              style: theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.primary.withValues(
                  alpha: newToggle! ? 1 : 0.2,
                ),
              ),
            ),
            const Gap(8.0),
            SizedBox(
              width: 50,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.primary.withValues(
                    alpha: newToggle! ? 1 : 0.2,
                  ),
                ),
                enabled: newToggle!,
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                onChanged: (String input) {
                  if (input.isEmpty) return;
                  int time = int.parse(input);
                  if (time < 1) {
                    setState(() {
                      controller.text = newFrequency.toString();
                    });
                  } else {
                    setState(() {
                      newFrequency = time;
                    });
                    widget.onFrequencyChange(newFrequency);
                  }
                },
                onEditingComplete: () {
                  if (controller.text.isEmpty) {
                    setState(() {
                      controller.text = newFrequency.toString();
                    });
                  }
                },
              ),
            ),
            const Gap(8.0),
            Text(
              "Tagen Inaktivität, um ",
              style: theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.primary.withValues(
                  alpha: newToggle! ? 1 : 0.2,
                ),
              ),
            ),
            const Gap(8.0),
            InkWell(
              onTap: newToggle!
                  ? () async {
                      final time = await showTimePicker(
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        context: context,
                        initialTime: newTime!,
                      );
                      if (time != null) {
                        setState(() {
                          newTime = time;
                        });
                        widget.onTimeChange(time);
                      }
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: newToggle!
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${newTime!.hour.toString().padLeft(2, "0")} : ${newTime!.minute.toString().padLeft(2, "0")}",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.colorScheme.primary.withValues(
                      alpha: newToggle! ? 1 : 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
