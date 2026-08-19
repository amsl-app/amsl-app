import 'dart:convert';

import 'package:amsl_app/models/hikari/assessments/assessment.dart';
import 'package:amsl_app/models/hikari/assessments/scale_data.dart';
import 'package:logging/logging.dart';

import '../../models/hikari/assessments/assessment_session.dart';
import '../hikari_api.dart';

class HikariAssessmentApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariAssessmentApi');

  const HikariAssessmentApi(this.hikari);

  Future<List<Assessment>> getAssessments() async => hikari.get(
    "/assessments",
    transform: (json) {
      List<Assessment> assessmentList = [];
      for (Map<String, dynamic> element in json) {
        assessmentList.add(Assessment.fromJson(element));
      }
      return assessmentList;
    },
  );

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

  Future<AssessmentSession> loadAssessmentSession({
    required String assessmentId,
    required String sessionID,
  }) async => hikari.get(
    "/assessments/$assessmentId/sessions/$sessionID",
    transform: (json) => AssessmentSession.fromJson(json),
  );

  Future<String> startAssessment({required String assessmentId}) async =>
      hikari.post(
        "/assessments/$assessmentId/start",
        transform: (json) => json['session_id'],
      );

  Future<void> submitAssessmentSession({
    required String assessmentId,
    required String sessionID,
    required List<Map<String, dynamic>> body,
  }) async => hikari.post(
    "/assessments/$assessmentId/sessions/$sessionID/submit",
    body: json.encode(body),
  );

  Future<void> updateQuestion({
    required String assessmentId,
    required String sessionID,
    required String questionID,
    required dynamic value,
  }) async => hikari.put(
    "/assessments/$assessmentId/sessions/$sessionID/update/$questionID",
    body: json.encode({'value': value}),
  );

  Future<List<ScaleData>> getScalesForSession(
    String assessmentId,
    String sessionId,
  ) async => hikari.get(
    "/assessments/$assessmentId/sessions/$sessionId/scales",
    transform: (json) {
      final scales = List.generate(
        json.length,
        (index) => ScaleData.fromJson(json[index]),
      );
      return scales;
    },
  );

  Future<List<TimedScaleData>> getScalesForAssessment(
    String assessmentId,
    String sessionId,
  ) async => hikari.get(
    "/assessments/$assessmentId/scales",
    transform: (json) {
      final scales = List.generate(
        json.length,
        (index) => TimedScaleData.fromJson(json[index]),
      );
      return scales;
    },
  );

  Future<List<AssessmentScaleData>> getScalesForAllAssessments() async =>
      hikari.get(
        "/assessments/scales",
        transform: (json) {
          final scales = List.generate(
            json.length,
            (index) => AssessmentScaleData.fromJson(json[index]),
          );
          return scales;
        },
      );

  Future<(String, String)> startAssessmentFromModule({
    required String moduleID,
    required AssessmentType assessmentType,
  }) async => hikari.post(
    "/modules/$moduleID/assessments/${assessmentType.name}/start",
    transform: (json) => (json['assessment_id'], json['session_id']),
  );
}
