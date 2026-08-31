import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/assessment/widgets/scale_series.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Bottom sheet content listing dated values (already normalized to the
/// same 1-5 range shown elsewhere), newest first.
class DataPointsSheet extends StatelessWidget {
  final String title;
  final String? description;
  final Map<DateTime, double> values;

  const DataPointsSheet({
    super.key,
    required this.title,
    required this.values,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = values.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (description != null)
          Text(
            description!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
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
            DataPointRow(date: entry.key, value: entry.value),
      ],
    );
  }
}

/// Wraps [DataPointsSheet] for a single [Scale], normalizing its raw
/// values onto the shared 1-5 range.
class ScaleDataPointsSheet extends StatelessWidget {
  final Scale scale;

  const ScaleDataPointsSheet({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return DataPointsSheet(
      title: scale.title,
      description: scale.description,
      values: {
        for (final entry in scale.values.entries)
          entry.key: normalizeScaleValue(entry.value, scale),
      },
    );
  }
}

class DataPointRow extends StatelessWidget {
  final DateTime date;
  final double value;

  const DataPointRow({super.key, required this.date, required this.value});

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
