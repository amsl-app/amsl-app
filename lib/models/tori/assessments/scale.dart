import '../../hikari/assessments/scale.dart' as hikari_scale;

class Scale {
  final String id;
  final String title;
  final double min;
  final double max;
  final Map<DateTime, double> values;

  Scale({
    required this.id,
    required this.title,
    required this.min,
    required this.max,
    required this.values,
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
      values: scaleData,
    );
  }
}
