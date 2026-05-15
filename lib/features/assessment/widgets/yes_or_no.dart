import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class YesOrNo extends StatelessWidget {
  final Function(bool) onChange;
  final bool? value;
  final String label;
  final String trueLabel;
  final String falseLabel;
  final Color labelColor;

  const YesOrNo({
    super.key,
    required this.onChange,
    required this.value,
    required this.label,
    required this.labelColor,
    required this.trueLabel,
    required this.falseLabel,
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
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClickableButton(
              value: true,
              isActive: value ?? false,
              label: trueLabel,
              onTap: onChange,
            ),
            ClickableButton(
              value: false,
              isActive: (value ?? true) ? false : true,
              label: falseLabel,
              onTap: onChange,
            ),
          ],
        ),
      ],
    );
  }
}

class ClickableButton extends StatelessWidget {
  final bool isActive;
  final String label;
  final Function onTap;
  final bool value;

  const ClickableButton({
    super.key,
    required this.isActive,
    required this.label,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.onSurface
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onSurface),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleMedium!.copyWith(
                color: isActive
                    ? theme.colorScheme.surface
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
