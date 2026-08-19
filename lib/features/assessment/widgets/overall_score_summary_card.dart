import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Prominent current-score readout, with a neutral trend indicator
/// against the previous entry (no good/bad coloring - higher isn't
/// always better depending on the scale), plus a small sparkline in the
/// same style as the per-category [ScaleTrendCard]s.
class OverallScoreSummaryCard extends StatelessWidget {
  final double latest;
  final double? previous;
  final List<FlSpot> spots;

  const OverallScoreSummaryCard({
    super.key,
    required this.latest,
    required this.spots,
    this.previous,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final delta = previous == null ? null : latest - previous!;
    final trendIcon = delta == null || delta.abs() < 0.05
        ? Icons.trending_flat
        : delta > 0
        ? Icons.trending_up
        : Icons.trending_down;

    return Container(
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
                  ],
                ),
              ),
              if (delta != null)
                Row(
                  children: [
                    Icon(trendIcon, color: theme.colorScheme.onSurfaceVariant),
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
              child: LineChart(
                LineChartData(
                  minY: 1,
                  maxY: 5,
                  lineTouchData: const LineTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: theme.colorScheme.primary,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.25),
                            theme.colorScheme.primary.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
