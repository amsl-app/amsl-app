import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/assessment/widgets/scale_series.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Bottom sheet content listing every datapoint for a scale (normalized
/// to the same 1-5 range shown elsewhere), newest first.
class ScaleDataPointsSheet extends StatelessWidget {
  final Scale scale;

  const ScaleDataPointsSheet({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = scale.values.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(scale.title, style: theme.textTheme.titleMedium),
        const Gap(12),
        if (entries.isEmpty)
          Text(
            "Noch keine Daten",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          for (final entry in entries)
            ScaleDataPointRow(
              date: entry.key,
              value: normalizeScaleValue(entry.value, scale),
            ),
      ],
    );
  }
}

class ScaleDataPointRow extends StatelessWidget {
  final DateTime date;
  final double value;

  const ScaleDataPointRow({super.key, required this.date, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kNewDateFormat.format(date), style: theme.textTheme.bodyMedium),
          Text(
            value.toStringAsFixed(1),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
