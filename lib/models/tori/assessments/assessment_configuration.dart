import 'package:freezed_annotation/freezed_annotation.dart';

import 'assessment.dart';
import 'overall_score.dart';
import 'scale.dart';

part 'assessment_configuration.freezed.dart';

@freezed
abstract class AssessmentConfiguration with _$AssessmentConfiguration {
  factory AssessmentConfiguration({
    required Map<String, Assessment> assessments,
  }) = _AssessmentConfiguration;

  AssessmentConfiguration._();

  Iterable<Assessment> get shownAssessments =>
      assessments.values.where((assessment) => !assessment.hidden);

  List<Scale> get scales => [
    for (final assessment in shownAssessments) ...assessment.scales,
  ];

  /// Averages all scales into a single day-by-day score, normalized to a
  /// 1-5 range. Each day's value carries forward the latest known value
  /// per scale, so scales that weren't re-measured on a given day still
  /// contribute their most recent value to the average.
  OverallScore? get overallScore {
    final overallByDay = _overallScoreByDay();
    final sortedDates = overallByDay.keys.toList()..sort();
    if (sortedDates.isEmpty) return null;

    final latest = overallByDay[sortedDates.last]!;
    final previous = sortedDates.length < 2
        ? null
        : overallByDay[sortedDates[sortedDates.length - 2]];

    final normalizedReferences = [
      for (final scale in scales)
        if (scale.reference != null)
          normalizeScaleValue(scale.reference!, scale),
    ];
    final reference = normalizedReferences.isEmpty
        ? null
        : normalizedReferences.reduce((a, b) => a + b) /
              normalizedReferences.length;

    return OverallScore(
      latest: latest,
      previous: previous,
      reference: reference,
      values: overallByDay,
    );
  }

  Map<DateTime, double> _overallScoreByDay() {
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
}
