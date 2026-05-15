import 'dart:convert';

import 'package:amsl_app/models/hikari/assessments/scale_data.dart';
import 'package:logging/logging.dart';

import '../../models/hikari/assessments/assessment_session.dart';
import '../hikari_api.dart';

class HikariAssessmentApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariAssessmentApi');

  const HikariAssessmentApi(this.hikari);
  Future<List<AssessmentSession>> getAssessmentSessions() async => hikari.get(
    "/assessments/sessions",
    transform: (json) {
      List<AssessmentSession> assessmentList = [];
      for (Map<String, dynamic> element in json) {
        assessmentList.add(AssessmentSession.fromJson(element));
      }
      return assessmentList;
    },
  );

  Future<AssessmentSession> loadAssessment({
    required String assessmentID,
    required String sessionID,
  }) async => hikari.get(
    "/assessments/$assessmentID/sessions/$sessionID/load",
    transform: (json) => AssessmentSession.fromJson(json),
  );

  Future<(String, String)> startAssessment({
    required String moduleID,
    required AssessmentType assessmentType,
  }) async => hikari.post(
    "/modules/$moduleID/assessments/${assessmentType.name}/start",
    transform: (json) => (json['assessment_id'], json['session_id']),
  );

  Future<void> updateQuestion({
    required String assessmentID,
    required String sessionID,
    required String questionID,
    required dynamic value,
  }) async => hikari.put(
    "/assessments/$assessmentID/sessions/$sessionID/update/$questionID",
    body: json.encode({'value': value}),
  );

  Future<void> submitAssessment({
    required String moduleID,
    required AssessmentType assessmentType,
    required List<Map<String, dynamic>> body,
  }) async => hikari.post(
    "/modules/$moduleID/assessments/${assessmentType.name}/submit",
    body: json.encode(body),
  );

  Future<Map<String, ScaleData>> getScaleData(
    String assessmentId,
    String sessionId,
  ) async => hikari.get(
    "/assessments/$assessmentId/sessions/$sessionId/scales",
    transform: (json) {
      final scaleData = List.generate(
        json.length,
        (index) => ScaleData.fromJson(json[index]),
      );
      return {for (ScaleData scale in scaleData) scale.id: scale};
    },
  );
}
