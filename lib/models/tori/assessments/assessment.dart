import 'package:amsl_app/models/hikari/assessments/assessment.dart'
    as hikari_assessment;
import 'package:amsl_app/models/hikari/assessments/scale_data.dart';
import 'package:amsl_app/models/tori/assessments/question.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';

class Assessment {
  final String assessmentId;
  final String title;
  final List<Question> questions;
  final List<Scale> scales;

  Assessment({
    required this.assessmentId,
    required this.title,
    required this.questions,
    required this.scales,
  });

  factory Assessment.fromHikari(
    hikari_assessment.Assessment assessment,
    List<TimedScaleData> scalesData,
  ) {
    Map<String, Map<DateTime, double>> scaleData = {};

    for (var scale in scalesData) {
      final completed = scale.completed;
      for (var value in scale.scales) {
        scaleData.putIfAbsent(value.id, () => {})[completed] = value.value;
      }
    }

    final scales = scaleData
        .map((scaleId, values) {
          final scale = assessment.scales.firstWhere((s) => s.id == scaleId);
          return MapEntry(scaleId, Scale.fromHikari(scale, values));
        })
        .values
        .toList();

    return Assessment(
      assessmentId: assessment.assessmentId,
      title: assessment.title,
      questions: assessment.questions
          .map((question) => Question.fromHikari(question))
          .toList(),
      scales: scales,
    );
  }
}
