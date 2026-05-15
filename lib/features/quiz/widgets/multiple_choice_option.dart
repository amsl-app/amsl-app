import 'package:flutter/material.dart';

class MultipleChoiceOption extends StatelessWidget {
  final String label;
  final void Function() onSelect;
  final bool isSelected;

  const MultipleChoiceOption({
    super.key,
    required this.label,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double br = 8;

    return ClipRRect(
      borderRadius: BorderRadius.circular(br),
      child: Material(
        color: isSelected ? theme.colorScheme.primary : Colors.white,
        child: Ink(
          child: InkWell(
            onTap: onSelect,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(br),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Text(
                label,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: isSelected ? Colors.white : theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
