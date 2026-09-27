import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Compact sparkline shared by [ScaleTrendCard] and
/// [OverallScoreSummaryCard]: a curved gradient-filled line on a 1-5
/// scale, with an optional dashed reference line.
class ScaleSparkline extends StatelessWidget {
  final List<FlSpot> spots;
  final Color color;
  final double? referenceY;

  const ScaleSparkline({
    super.key,
    required this.spots,
    required this.color,
    this.referenceY,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LineChart(
      LineChartData(
        minY: 1,
        maxY: 5,
        lineTouchData: const LineTouchData(enabled: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        extraLinesData: referenceY == null
            ? const ExtraLinesData()
            : ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: referenceY!,
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                    strokeWidth: 1,
                    dashArray: const [4, 3],
                  ),
                ],
              ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.25),
                  color.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
