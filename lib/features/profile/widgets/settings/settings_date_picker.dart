import 'package:amsl_app/constants.dart';
import 'package:flutter/material.dart';

class SettingsDatePicker extends StatefulWidget {
  final DateTime? initialValue;
  final String label;
  final Function onChange;

  const SettingsDatePicker({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.label,
  });

  @override
  State<SettingsDatePicker> createState() => _SettingsDatePickerState();
}

class _SettingsDatePickerState extends State<SettingsDatePicker> {
  late DateTime? newValue;

  static DateTime firstDate = DateTime.parse('1900-01-01');
  static DateTime lastDate = DateTime.now();

  @override
  void initState() {
    newValue = widget.initialValue;
    super.initState();
  }

  void setValue(DateTime? newDateTime) {
    setState(() {
      newValue = newDateTime;
    });
    widget.onChange(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    TextStyle style = theme.textTheme.bodyLarge!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: theme.textTheme.titleMedium!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: GestureDetector(
              onTap: () async {
                DateTime? tempDate = await showDatePicker(
                  context: context,
                  initialDate: getInitialDate(),
                  firstDate: firstDate,
                  lastDate: lastDate,
                );

                if (tempDate != null) {
                  setValue(tempDate);
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.colorScheme.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        newValue != null
                            ? kNewDateFormat.format(newValue!).toString()
                            : "Keine Angabe",
                        style: style,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: newValue != null,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setValue(null),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime? getInitialDate() {
    if (newValue == null) return DateTime.now();

    if (newValue!.isBefore(firstDate)) return DateTime.now();
    if (newValue!.isAfter(lastDate)) return DateTime.now();

    return newValue;
  }
}
