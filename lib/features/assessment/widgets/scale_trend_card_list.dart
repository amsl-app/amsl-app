import 'package:amsl_app/features/assessment/widgets/scale_series.dart';
import 'package:amsl_app/features/assessment/widgets/scale_trend_card.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:amsl_app/widgets/section_header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// One [ScaleTrendCard] small multiple per scale, sorted by name.
class ScaleTrendCardList extends StatelessWidget {
  final List<Scale> scales;

  const ScaleTrendCardList({super.key, required this.scales});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.error,
      theme.colorScheme.primaryContainer,
      theme.colorScheme.secondaryContainer,
      theme.colorScheme.tertiaryContainer,
      theme.colorScheme.errorContainer,
    ];

    final sortedScales = [...scales]
      ..sort((a, b) => a.title.compareTo(b.title));

    final series = [
      for (final (index, scale) in sortedScales.indexed)
        ScaleSeries(
          scale: scale,
          color: colors[index % colors.length],
          spots:
              (scale.values.entries.toList()
                    ..sort((a, b) => a.key.compareTo(b.key)))
                  .indexed
                  .map(
                    (e) => FlSpot(
                      e.$1.toDouble(),
                      normalizeScaleValue(e.$2.value, scale),
                    ),
                  )
                  .toList(),
        ),
    ];

    // Rank by latest value: best/worst can only be judged where there's
    // data. Worst is drawn from whatever's left after best, so the two
    // groups never overlap even with few scales.
    final withData = [...series.where((s) => s.latestValue != null)]
      ..sort((a, b) => b.latestValue!.compareTo(a.latestValue!));
    final best = withData.take(2).toList();
    final remaining = withData.skip(2).toList()
      ..sort((a, b) => a.latestValue!.compareTo(b.latestValue!));
    final worst = remaining.take(2).toList();
    final worstIds = worst.map((s) => s.scale.id).toSet();
    final others =
        [
          ...remaining.where((s) => !worstIds.contains(s.scale.id)),
          ...series.where((s) => s.latestValue == null),
        ]..sort((a, b) => a.scale.title.compareTo(b.scale.title));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(text: "KATEGORIEN"),
        const Gap(12),
        if (best.isNotEmpty) ...[
          _subheader(theme, "Beste"),
          const Gap(8),
          for (final s in best) ...[
            ScaleTrendCard(series: s),
            const Gap(12),
          ],
        ],
        if (worst.isNotEmpty) ...[
          _subheader(theme, "Schlechteste"),
          const Gap(8),
          for (final s in worst) ...[
            ScaleTrendCard(series: s),
            const Gap(12),
          ],
        ],
        if (others.isNotEmpty) ...[
          _subheader(theme, "Weitere"),
          const Gap(8),
          for (final s in others) ...[
            ScaleTrendCard(series: s),
            const Gap(12),
          ],
        ],
      ],
    );
  }

  Widget _subheader(ThemeData theme, String label) {
    return Text(
      label.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
