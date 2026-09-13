import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LinearScale extends StatelessWidget {
  final Function(int?) onChange;
  final String label;
  final int min;
  final int max;
  final String leftLabel;
  final String rightLabel;
  final int? value;
  final Color labelColor;

  const LinearScale({
    super.key,
    required this.onChange,
    required this.label,
    this.leftLabel = "sehr niedrig",
    this.rightLabel = "sehr hoch",
    this.min = 1,
    this.max = 5,
    required this.value,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        const Gap(5),
        _buildRadioButtons(theme),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100),
              child: Text(
                leftLabel,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100),
              child: Text(
                rightLabel,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButtons(ThemeData theme) {
    final children = List<Widget>.from(
      Iterable.generate(max - min + 1, (index) {
        return RadioGroup<int>(
          onChanged: (value) => onChange(value),
          groupValue: value,
          child: Radio<int>(
            value: index + min,
            visualDensity: VisualDensity.compact,
            fillColor: WidgetStateColor.resolveWith(
              (states) => theme.colorScheme.onSurface,
            ),
          ),
        );
      }),
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
