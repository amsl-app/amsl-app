import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryIcon extends StatelessWidget {
  final String label;
  final bool checked;

  const SummaryIcon({super.key, required this.label, required this.checked});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const lightYellow = Color.fromRGBO(245, 231, 202, 1.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: checked ? theme.colorScheme.primary : lightYellow,
            child: checked
                ? const Icon(Icons.check, size: 20, color: lightYellow)
                : const SizedBox(height: 20, width: 20),
          ),
        ),
        const Gap(8.0),
        Text(label, style: theme.textTheme.titleSmall),
      ],
    );
  }
}
