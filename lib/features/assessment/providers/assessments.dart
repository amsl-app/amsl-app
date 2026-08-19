import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/hikari/assessments/scale_data.dart';
import 'package:amsl_app/models/tori/assessments/assessment.dart';
import 'package:amsl_app/models/hikari/assessments/assessment.dart'
    as hikari_assessment;
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assessments.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class AssessmentPod extends _$AssessmentPod {
  static final log = Logger("AssessmentPod");

  @override
  Future<Map<String, Assessment>> build() async {
    final hikari = ref.watch(hikariPodProvider);

    return await _loadAssessmentsFromApi(hikari);
  }

  Future<Map<String, Assessment>> _loadAssessmentsFromApi(Hikari hikari) async {
    final result = await Future.wait([
      hikari.assessmentApi.getAssessments(),
      hikari.assessmentApi.getScalesForAllAssessments(),
    ]);

    final List<hikari_assessment.Assessment> assessments =
        result[0] as List<hikari_assessment.Assessment>;
    final List<AssessmentScaleData> scalesData =
        result[1] as List<AssessmentScaleData>;

    final Iterable<MapEntry<String, Assessment>> zipped = assessments.map((
      assessment,
    ) {
      final AssessmentScaleData? scaleData = scalesData.firstWhereOrNull(
        (scaleData) => scaleData.assessmentId == assessment.assessmentId,
      );

      return MapEntry(
        assessment.assessmentId,
        Assessment.fromHikari(assessment, scaleData?.sessions ?? []),
      );
    });

    return Map.fromEntries(zipped);
  }

  Future<Map<String, Assessment>> reloadAssessments() async {
    ref.invalidateSelf();
    return future;
  }
}
