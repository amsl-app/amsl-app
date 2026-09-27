import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LinearNumberedBoxScale extends StatelessWidget {
  final Function(int?) onChange;
  final String label;
  final int min;
  final int max;
  final String leftLabel;
  final String rightLabel;
  final int? value;
  final Color labelColor;

  const LinearNumberedBoxScale({
    super.key,
    required this.onChange,
    required this.label,
    required this.leftLabel,
    required this.rightLabel,
    required this.min,
    required this.max,
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
        _buildNumberedBoxButtons(theme),
        const Gap(5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildNumberedBoxButtons(ThemeData theme) {
    final children = List<Widget>.from(
      Iterable.generate(max - min + 1, (index) {
        return NumberedBox(
          value: index + min,
          groupValue: value,
          primaryColor: theme.colorScheme.primary,
          secondaryColor: theme.colorScheme.onPrimary,
          onChanged: (int? value) => onChange(value),
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

class NumberedBox extends StatelessWidget {
  final int value;
  final int? groupValue;
  final Color primaryColor;
  final Color secondaryColor;
  final Function(int?) onChanged;

  const NumberedBox({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: (groupValue != null && groupValue == value)
              ? primaryColor
              : secondaryColor,
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          value.toString(),
          style: theme.textTheme.titleSmall!.copyWith(
            color: (groupValue != null && groupValue == value)
                ? secondaryColor
                : primaryColor,
          ),
        ),
      ),
    );
  }
}
