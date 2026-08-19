import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/hikari.dart';
import '../../../models/tori/assessments/question.dart';
import '../../../providers/hikari_provider.dart';

part 'assessment_sessions.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class AssessmentSessions extends _$AssessmentSessions {
  static final log = Logger("AssessmentSessions");

  @override
  FutureOr<Map<String, ToriAssessmentSession>> build() async {
    final hikari = ref.watch(hikariPodProvider);

    return await _loadAssessmentSessionsFromApi(hikari);
  }

  Future<Map<String, ToriAssessmentSession>> _loadAssessmentSessionsFromApi(
    Hikari hikari,
  ) async {
    final List<ToriAssessmentSession> assessmentSessions;
    try {
      final List<hikari_assessment.AssessmentSession> hikariAssessmentSessions =
          await hikari.assessmentApi.getAssessmentSessions();

      assessmentSessions = hikariAssessmentSessions.map((e) {
        return ToriAssessmentSession.fromHikari(e);
      }).toList();
    } on HikariException catch (exception) {
      throw exception.copyWith(resolve: reloadAssessmentSessions);
    }
    log.info("Loaded ${assessmentSessions.length} assessmentSessions");
    return {for (var session in assessmentSessions) session.sessionId: session};
  }

  Future<ToriAssessmentSession> _loadSingleAssessmentSessionFromApi(
    Hikari hikari, {
    required String assessmentId,
    required String sessionID,
  }) async {
    final ToriAssessmentSession assessmentSession;

    try {
      final hikari_assessment.AssessmentSession hikariAssessment = await hikari
          .assessmentApi
          .loadAssessmentSession(
            assessmentId: assessmentId,
            sessionID: sessionID,
          );

      assessmentSession = ToriAssessmentSession.fromHikari(hikariAssessment);
    } on HikariException catch (exception) {
      throw exception.copyWith(resolve: reloadSingleAssessmentSession);
    }
    return assessmentSession;
  }

  Future<Map<String, ToriAssessmentSession>> reloadAssessmentSessions() async {
    ref.invalidateSelf();
    return future;
  }

  Future<ToriAssessmentSession> reloadSingleAssessmentSession({
    required String assessmentId,
    required String sessionID,
  }) async {
    final hikari = ref.watch(hikariPodProvider);
    try {
      final session = await _loadSingleAssessmentSessionFromApi(
        hikari,
        assessmentId: assessmentId,
        sessionID: sessionID,
      );
      update((state) {
        state[sessionID] = session;
        return state;
      });
      return session;
    } on HikariException catch (e, s) {
      final exception = e.copyWith(
        resolve: () => reloadSingleAssessmentSession(
          assessmentId: assessmentId,
          sessionID: sessionID,
        ),
      );
      state = AsyncValue.error(exception, s);
      throw exception;
    } on Exception catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    }
  }

  Future<ToriAssessmentSession> startModuleAssessment(
    String moduleID,
    hikari_assessment.AssessmentType assessmentType,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    //Create assessment in Database
    final String assessmentId;
    final String sessionID;

    try {
      (assessmentId, sessionID) = await hikari.assessmentApi
          .startAssessmentFromModule(
            moduleID: moduleID,
            assessmentType: assessmentType,
          );
      log.info("New Assessment: $assessmentId with Session: $sessionID");
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => startModuleAssessment(moduleID, assessmentType),
      );
    }
    //Load the new assessment into the state and handle the error with correct resolve
    return reloadSingleAssessmentSession(
      assessmentId: assessmentId,
      sessionID: sessionID,
    );
  }

  Future<ToriAssessmentSession> startAssessment(String assessmentId) async {
    final hikari = ref.read(hikariPodProvider);
    //Create assessment in Database
    final String sessionID;

    try {
      sessionID = await hikari.assessmentApi.startAssessment(
        assessmentId: assessmentId,
      );
      log.info("New Assessment: $assessmentId with Session: $sessionID");
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => startAssessment(assessmentId));
    }
    //Load the new assessment into the state and handle the error with correct resolve
    return reloadSingleAssessmentSession(
      assessmentId: assessmentId,
      sessionID: sessionID,
    );
  }

  void saveAssessmentLocally(ToriAssessmentSession assessmentSession) {
    update((state) {
      for (Question q in assessmentSession.questions.values) {
        state[assessmentSession.sessionId]!.questions[q.id]!.answer = q.answer;
      }
      return state;
    });
  }

  Future<void> submitAssessment({
    required ToriAssessmentSession assessmentSession,
  }) async {
    final hikari = ref.read(hikariPodProvider);

    log.info(
      "Submitting Assessment ${assessmentSession.assessmentId} with Session ${assessmentSession.sessionId}",
    );

    List<Map<String, dynamic>> body = assessmentSession.questionsToJson();
    try {
      await hikari.assessmentApi.submitAssessmentSession(
        assessmentId: assessmentSession.assessmentId,
        sessionID: assessmentSession.sessionId,
        body: body,
      );
      saveAssessmentLocally(assessmentSession);
      update((state) {
        final session = state[assessmentSession.sessionId];
        state[assessmentSession.sessionId] = session!.copyWith(
          completed: DateTime.now(),
          status: hikari_assessment.AssessmentStatus.finished,
        );
        return state;
      });
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => submitAssessment(assessmentSession: assessmentSession),
      );
    }
  }
}
