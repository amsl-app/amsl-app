import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LinearSlider extends StatelessWidget {
  final int? value;
  final Function(int) onChange;
  final String label;
  final int min;
  final int max;
  final String leftLabel;
  final String rightLabel;
  final Color labelColor;

  const LinearSlider({
    super.key,
    required this.value,
    required this.onChange,
    required this.label,
    required this.labelColor,
    this.leftLabel = "sehr niedrig",
    this.rightLabel = "sehr hoch",
    this.min = 1,
    this.max = 5,
  });

  @override
  Widget build(BuildContext context) {
    double value = (this.value ?? 0).toDouble();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 80),
              child: Text(
                leftLabel,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  valueIndicatorTextStyle: theme.textTheme.titleSmall,
                  valueIndicatorColor: theme.colorScheme.onSurface,
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                ),
                child: Slider(
                  activeColor: theme.colorScheme.onSurface,
                  inactiveColor: theme.colorScheme.onSurface,
                  thumbColor: theme.colorScheme.onSurface,
                  label: value.toInt().toString(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (i) => onChange(i.toInt()),
                  value: value,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 80),
              child: Text(
                rightLabel,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
