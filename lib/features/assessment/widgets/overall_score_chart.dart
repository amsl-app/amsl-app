import 'package:amsl_app/features/assessment/widgets/overall_score_summary_card.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A single trend line averaging every scale's value, each min-max
/// normalized to a 1-5 scale so differently scaled scores remain
/// comparable.
///
/// A day rarely updates every scale at once (e.g. "just this part" only
/// retakes one subassessment), so each scale's last known value is
/// carried forward to any later day where it wasn't retaken - otherwise
/// the average on a partial-update day would only reflect the one or two
/// scales that changed and swing misleadingly.
class OverallScoreChart extends StatelessWidget {
  final List<Scale> scales;

  const OverallScoreChart({super.key, required this.scales});

  Map<DateTime, double> _overallByDay() {
    final perScaleDays = <List<MapEntry<DateTime, double>>>[];
    for (final scale in scales) {
      final range = scale.max - scale.min;
      if (range <= 0) continue;
      final byDay = <DateTime, double>{};
      for (final entry in scale.values.entries) {
        final fraction = ((entry.value - scale.min) / range).clamp(0.0, 1.0);
        final normalized = 1 + fraction * 4;
        final day = DateTime(entry.key.year, entry.key.month, entry.key.day);
        byDay[day] = normalized;
      }
      if (byDay.isEmpty) continue;
      final sorted = byDay.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      perScaleDays.add(sorted);
    }

    final allDays = <DateTime>{};
    for (final days in perScaleDays) {
      allDays.addAll(days.map((e) => e.key));
    }
    final sortedDays = allDays.toList()..sort();

    // Merge-forward: each scale's cursor only advances, since both the
    // scale's own entries and sortedDays are ascending.
    final cursors = List<int>.filled(perScaleDays.length, -1);
    final overallByDay = <DateTime, double>{};
    for (final day in sortedDays) {
      final latestValues = <double>[];
      for (var i = 0; i < perScaleDays.length; i++) {
        final entries = perScaleDays[i];
        while (cursors[i] + 1 < entries.length &&
            !entries[cursors[i] + 1].key.isAfter(day)) {
          cursors[i]++;
        }
        if (cursors[i] >= 0) {
          latestValues.add(entries[cursors[i]].value);
        }
      }
      if (latestValues.isNotEmpty) {
        overallByDay[day] =
            latestValues.reduce((a, b) => a + b) / latestValues.length;
      }
    }
    return overallByDay;
  }

  @override
  Widget build(BuildContext context) {
    final overallByDay = _overallByDay();
    final sortedDates = overallByDay.keys.toList()..sort();

    if (sortedDates.isEmpty) {
      return const SizedBox.shrink();
    }

    final latest = overallByDay[sortedDates.last]!;
    final previous = sortedDates.length < 2
        ? null
        : overallByDay[sortedDates[sortedDates.length - 2]];

    return OverallScoreSummaryCard(
      latest: latest,
      previous: previous,
      spots: [
        for (final (index, date) in sortedDates.indexed)
          FlSpot(index.toDouble(), overallByDay[date]!),
      ],
    );
  }
}
