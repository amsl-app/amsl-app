import '../../hikari/assessments/scale.dart' as hikari_scale;
import '../../hikari/assessments/scale_data.dart' as hikari_scale_data;

class Scale {
  final String id;
  final String title;
  final double min;
  final double max;
  final double? value;

  Scale.fromHikari(
    hikari_scale.Scale scale,
    hikari_scale_data.ScaleData? scaleData,
  ) : id = scale.id,
      title = scale.title,
      min = scale.body.min,
      max = scale.body.max,
      value = scaleData?.value;
}
