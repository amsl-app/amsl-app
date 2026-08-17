import 'package:amsl_app/models/tori/assessments/assessment.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Bottom sheet content listing every subassessment; tapping one starts
/// just that part.
class SubassessmentPickerSheet extends StatelessWidget {
  final List<Assessment> assessments;
  final ValueChanged<Assessment> onSelect;

  const SubassessmentPickerSheet({
    super.key,
    required this.assessments,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Einzelnen Teil starten", style: theme.textTheme.titleMedium),
        const Gap(12),
        for (final assessment in assessments)
          SubassessmentPickerTile(
            title: assessment.title,
            onTap: () => onSelect(assessment),
          ),
      ],
    );
  }
}

class SubassessmentPickerTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubassessmentPickerTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(child: Text(title, style: theme.textTheme.bodyMedium)),
            Icon(Icons.play_arrow, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
