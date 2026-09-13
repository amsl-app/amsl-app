import 'package:amsl_app/features/assessment/widgets/data_points_sheet.dart';
import 'package:amsl_app/features/assessment/widgets/scale_sparkline.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Prominent current-score readout, with a neutral trend indicator
/// against the previous entry (no good/bad coloring - higher isn't
/// always better depending on the scale), plus a small sparkline in the
/// same style as the per-category [ScaleTrendCard]s. Tapping it opens
/// the raw datapoints, same as a [ScaleTrendCard].
class OverallScoreSummaryCard extends StatelessWidget {
  final double latest;
  final double? previous;
  final double? reference;
  final Map<DateTime, double> values;
  final List<FlSpot> spots;

  const OverallScoreSummaryCard({
    super.key,
    required this.latest,
    required this.values,
    required this.spots,
    this.previous,
    this.reference,
  });

  Future<void> _openDataPoints(BuildContext context) async {
    await showAmslBottomSheet(
      context: context,
      bottomBar: true,
      onClose: () => context.pop(),
      child: DataPointsSheet(
        title: "Gesamtwert",
        values: values,
        description: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final delta = previous == null ? null : latest - previous!;
    final trendIcon = delta == null || delta.abs() < 0.05
        ? Icons.trending_flat
        : delta > 0
        ? Icons.trending_up
        : Icons.trending_down;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openDataPoints(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aktueller Gesamtwert",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            latest.toStringAsFixed(1),
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "/ 5",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (reference != null) ...[
                        const Gap(4),
                        Text(
                          "Ø ${reference!.toStringAsFixed(1)}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (delta != null)
                  Row(
                    children: [
                      Icon(
                        trendIcon,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const Gap(4),
                      Text(
                        "${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (spots.length > 1) ...[
              const Gap(12),
              SizedBox(
                height: 36,
                child: ScaleSparkline(
                  spots: spots,
                  color: theme.colorScheme.primary,
                  referenceY: reference,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
