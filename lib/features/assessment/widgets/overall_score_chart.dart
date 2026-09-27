import 'package:amsl_app/features/assessment/providers/assessments.dart';
import 'package:amsl_app/features/assessment/widgets/overall_score_summary_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverallScoreChart extends ConsumerWidget {
  const OverallScoreChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overallScore = ref
        .watch(assessmentPodProvider)
        .asData
        ?.value
        .overallScore;

    if (overallScore == null) {
      return const SizedBox.shrink();
    }

    final sortedDates = overallScore.values.keys.toList()..sort();

    return OverallScoreSummaryCard(
      latest: overallScore.latest,
      previous: overallScore.previous,
      reference: overallScore.reference,
      values: overallScore.values,
      spots: [
        for (final (index, date) in sortedDates.indexed)
          FlSpot(index.toDouble(), overallScore.values[date]!),
      ],
    );
  }
}
