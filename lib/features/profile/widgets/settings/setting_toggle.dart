import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsToggle extends StatefulWidget {
  final String label;
  final Function onToggle;
  final bool initToggle;

  const SettingsToggle({
    super.key,
    required this.label,
    required this.onToggle,
    required this.initToggle,
  });

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  bool? newToggle;

  @override
  Widget build(BuildContext context) {
    newToggle ??= widget.initToggle;

    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(widget.label, style: theme.textTheme.titleSmall)),
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
