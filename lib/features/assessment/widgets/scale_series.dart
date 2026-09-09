import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
