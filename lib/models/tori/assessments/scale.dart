import '../../hikari/assessments/scale.dart' as hikari_scale;

class Scale {
  final String id;
  final String title;
  final double min;
  final double max;
  final double? reference;
  final String? description;
  final Map<DateTime, double> values;

  Scale({
    required this.id,
    required this.title,
    required this.min,
    required this.max,
    required this.values,
    this.reference,
    this.description,
  });

  factory Scale.fromHikari(
    hikari_scale.Scale scale,
    Map<DateTime, double> scaleData,
  ) {
    return Scale(
      id: scale.id,
      title: scale.title,
      min: scale.body.min,
      max: scale.body.max,
      reference: scale.body.reference,
      values: scaleData,
      description: scale.description,
    );
  }
}

/// Min-max normalizes a scale's raw value onto a 1-5 range, so
/// differently scaled scores are comparable and consistent everywhere
/// they're displayed.
double normalizeScaleValue(double value, Scale scale) {
  final range = scale.max - scale.min;
  if (range <= 0) return 1;
  return 1 + ((value - scale.min) / range).clamp(0.0, 1.0) * 4;
}
