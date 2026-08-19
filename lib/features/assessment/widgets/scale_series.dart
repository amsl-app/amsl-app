import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Min-max normalizes a scale's raw value onto a 1-5 range, so
/// differently scaled scores are comparable and consistent everywhere
/// they're displayed.
double normalizeScaleValue(double value, Scale scale) {
  final range = scale.max - scale.min;
  if (range <= 0) return 1;
  return 1 + ((value - scale.min) / range).clamp(0.0, 1.0) * 4;
}

/// A scale paired with its assigned display color and its plotted spots
/// (x = days since the chart's reference date, y = normalized 1-5 value).
class ScaleSeries {
  final Scale scale;
  final Color color;
  final List<FlSpot> spots;

  const ScaleSeries({
    required this.scale,
    required this.color,
    required this.spots,
  });

  double? get latestValue => spots.isEmpty ? null : spots.last.y;
}
