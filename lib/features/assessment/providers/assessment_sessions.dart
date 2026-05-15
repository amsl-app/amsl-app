import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/models/hikari/assessments/scale_data.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/hikari.dart';
import '../../../models/tori/assessments/question.dart';
import '../../../models/tori/modules/module_assessment.dart';
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

      Iterable<Future<Map<String, ScaleData>?>> asyncScales =
          hikariAssessmentSessions.map((e) {
            if (e.completed != null) {
              return hikari.assessmentApi.getScaleData(
                e.assessment.assessmentId,
                e.sessionId,
              );
            }
            // This is necessary to map the scales to assessment via index
            return Future.value(null);
          });
      final List<Map<String, ScaleData>?> scales = await Future.wait(
        asyncScales,
      );

      assessmentSessions = hikariAssessmentSessions.mapIndexed((index, e) {
        return ToriAssessmentSession.fromHikari(e, scales[index]);
      }).toList();
    } on HikariException catch (exception) {
      throw exception.copyWith(resolve: reloadAssessmentSessions);
    }
    log.info("Loaded ${assessmentSessions.length} assessmentSessions");
    return {for (var session in assessmentSessions) session.sessionId: session};
  }

  Future<ToriAssessmentSession> _loadSingleAssessmentSessionFromApi(
    Hikari hikari, {
    required String assessmentID,
    required String sessionID,
  }) async {
    final ToriAssessmentSession assessmentSession;

    try {
      final hikari_assessment.AssessmentSession hikariAssessment = await hikari
          .assessmentApi
          .loadAssessment(assessmentID: assessmentID, sessionID: sessionID);
      Map<String, ScaleData>? scales;
      if (hikariAssessment.completed != null) {
        scales = await hikari.assessmentApi.getScaleData(
          assessmentID,
          sessionID,
        );
      } else {
        scales = null;
      }
      assessmentSession = ToriAssessmentSession.fromHikari(
        hikariAssessment,
        scales,
      );
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
    required String assessmentID,
    required String sessionID,
  }) async {
    final hikari = ref.watch(hikariPodProvider);
    try {
      final session = await _loadSingleAssessmentSessionFromApi(
        hikari,
        assessmentID: assessmentID,
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
          assessmentID: assessmentID,
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

  Future<ToriAssessmentSession> startAssessment(
    String moduleID,
    hikari_assessment.AssessmentType assessmentType,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    //Create assessment in Database
    final String assessmentID;
    final String sessionID;

    try {
      (assessmentID, sessionID) = await hikari.assessmentApi.startAssessment(
        moduleID: moduleID,
        assessmentType: assessmentType,
      );
      log.info("New Assessment: $assessmentID with Session: $sessionID");
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => startAssessment(moduleID, assessmentType),
      );
    }
    //Load the new assessment into the state and handle the error with correct resolve
    return reloadSingleAssessmentSession(
      assessmentID: assessmentID,
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
    required ModuleAssessmentSet moduleAssessmentSet,
    required hikari_assessment.AssessmentType assessmentType,
  }) async {
    final hikari = ref.read(hikariPodProvider);

    ToriAssessmentSession assessmentSession =
        (assessmentType == hikari_assessment.AssessmentType.pre)
        ? moduleAssessmentSet.preAssessment.assessmentSession!
        : moduleAssessmentSet.postAssessment.assessmentSession!;

    log.info(
      "Submitting ${assessmentType.name}-Assessment for module ${moduleAssessmentSet.module.id}",
    );

    List<Map<String, dynamic>> body = assessmentSession.questionsToJson();
    try {
      await hikari.assessmentApi.submitAssessment(
        moduleID: moduleAssessmentSet.module.id,
        assessmentType: assessmentType,
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
        resolve: () => submitAssessment(
          moduleAssessmentSet: moduleAssessmentSet,
          assessmentType: assessmentType,
        ),
      );
    }
  }
}
