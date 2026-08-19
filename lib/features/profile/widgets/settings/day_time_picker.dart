import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DayTimePicker extends StatefulWidget {
  final String label;
  final Function onToggle;
  final Function onTimeChange;
  final Function onDayChange;

  final Map<int, String> dayOptions;
  final int initDay;
  final TimeOfDay initTime;
  final bool initToggle;

  const DayTimePicker({
    super.key,
    required this.label,
    required this.dayOptions,
    required this.onDayChange,
    required this.onTimeChange,
    required this.onToggle,
    required this.initDay,
    required this.initTime,
    required this.initToggle,
  });

  @override
  State<DayTimePicker> createState() => _DayTimePickerState();
}

class _DayTimePickerState extends State<DayTimePicker> {
  bool? newToggle;
  TimeOfDay? newTime;
  int? newDay;

  @override
  Widget build(BuildContext context) {
    newTime ??= widget.initTime;
    newToggle ??= widget.initToggle;
    newDay ??= widget.initDay;

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<int>(
              value: newDay,
              underline: const SizedBox.shrink(),
              disabledHint: Text(
                widget.dayOptions[newDay] ?? "",
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              onChanged: newToggle!
                  ? (value) {
                      if (value == null) return;
                      setState(() {
                        newDay = value;
                      });
                      widget.onDayChange(value);
                    }
                  : null,
              items: [
                for (final entry in widget.dayOptions.entries)
                  DropdownMenuItem(value: entry.key, child: Text(entry.value)),
              ],
            ),
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
