import 'package:amsl_app/features/modules/providers/module_group.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/exception.dart';
import '../../../hikari/hikari.dart';
import '../../../models/hikari/modules/session.dart' as hikari_session;
import '../../../models/tori/assessments/assessment_session.dart';
import '../../../models/tori/modules/module.dart';
import '../../../models/tori/modules/module_assessment.dart';
import '../../../models/tori/modules/session.dart';
import '../../../providers/hikari_provider.dart';
import '../../assessment/providers/assessment_sessions.dart';
import '../../tracking/tracking.dart';

part 'module_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [HikariPod, AssessmentSessions, ModuleGroupsProvider],
)
class ModuleNotifier extends _$ModuleNotifier {
  static final log = Logger("ModuleNotifier");

  @override
  Future<Map<String, ModuleAssessmentSet>> build() async {
    final hikari = ref.watch(hikariPodProvider);

    return _loadModulesFromApi(hikari);
  }

  Future<Map<String, ModuleAssessmentSet>> _loadModulesFromApi(
    Hikari hikari,
  ) async {
    // load everything in parallel
    final asyncAssessmentSessions = ref.watch(
      assessmentSessionsProvider.future,
    );

    final asyncModuleGroups = ref.watch(moduleGroupsProviderProvider.future);

    final List result = await Future.wait([
      () async {
        try {
          return hikari.moduleApi.getModules();
        } on HikariException catch (e) {
          throw e.copyWith(resolve: reloadModules);
        }
      }(),
      asyncAssessmentSessions,
      asyncModuleGroups,
    ]);

    //get relevant modules
    final hikariModules = result[0];
    final Map<String, ToriAssessmentSession> assessmentSessions = result[1];

    final toriModules = hikariModules
        .map((m) => Module.fromHikari(m))
        .toList(growable: false);

    // combine modules with assessments
    List modules = toriModules
        .map((module) {
          final ModuleAssessmentSession preAssessment = ModuleAssessmentSession(
            isDefined: module.assessments?["pre"] != null,
            assessmentSession:
                assessmentSessions[module.assessments?["last_pre"]],
          );

          final ModuleAssessmentSession postAssessment =
              ModuleAssessmentSession(
                isDefined: module.assessments?["post"] != null,
                assessmentSession:
                    assessmentSessions[module.assessments?["last_post"]],
              );

          return ModuleAssessmentSet(
            module: module,
            postAssessment: postAssessment,
            preAssessment: preAssessment,
          );
        })
        .toList(growable: false);

    log.info("Loaded ${modules.length} modules");
    return {for (var module in modules) module.module.id: module};
  }

  Future<ModuleAssessmentSet> _loadSingleModuleFromApi(
    Hikari hikari, {
    required String moduleID,
  }) async {
    final asyncAssessmentSessions = ref.watch(
      assessmentSessionsProvider.future,
    );
    final asyncModuleGroups = ref.watch(moduleGroupsProviderProvider.future);

    final List result = await Future.wait([
      () async {
        try {
          return hikari.moduleApi.getSingleModule(moduleID);
        } on HikariException catch (e) {
          throw e.copyWith(resolve: reloadModules);
        }
      }(),
      asyncAssessmentSessions,
      asyncModuleGroups,
    ]);

    final hikariModule = result[0];
    final Map<String, ToriAssessmentSession> assessmentSessions = result[1];
    final toriModule = Module.fromHikari(hikariModule);

    final ModuleAssessmentSession preAssessment = ModuleAssessmentSession(
      isDefined: toriModule.assessments?["pre"] != null,
      assessmentSession:
          assessmentSessions[toriModule.assessments?["last_pre"]],
    );

    final ModuleAssessmentSession postAssessment = ModuleAssessmentSession(
      isDefined: toriModule.assessments?["post"] != null,
      assessmentSession:
          assessmentSessions[toriModule.assessments?["last_post"]],
    );

    return ModuleAssessmentSet(
      module: toriModule,
      postAssessment: postAssessment,
      preAssessment: preAssessment,
    );
  }

  Future<Map<String, ModuleAssessmentSet>> reloadModules({
    bool complete = false,
  }) async {
    if (complete) {
      ref.read(assessmentSessionsProvider.notifier).reloadAssessmentSessions();
    } else {
      ref.invalidateSelf();
    }
    return future;
  }

  Future<ModuleAssessmentSet> reloadSingleModule({
    required String moduleID,
  }) async {
    final hikari = ref.watch(hikariPodProvider);

    try {
      final module = await _loadSingleModuleFromApi(hikari, moduleID: moduleID);
      update((state) async {
        state[moduleID] = module;
        return state;
      });
      return module;
    } on HikariException catch (e, s) {
      final exception = e.copyWith(
        resolve: () => reloadSingleModule(moduleID: moduleID),
      );
      state = AsyncValue.error(exception, s);
      throw exception;
    } on Exception catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    }
  }

  // TODO method to reload single module / single session

  Future<void> abortSession({
    required String moduleId,
    required String sessionId,
  }) async {
    log.fine("aborting session $moduleId/$sessionId");
    final session = state.value?[moduleId]?.module.sessions[sessionId];
    if (session == null) {
      log.warning(
        "Session not found locally while aborting: $moduleId/$sessionId",
      );
    }

    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.moduleApi.abortModuleSession(
        moduleId: moduleId,
        sessionId: sessionId,
      );
      if (session != null) {
        setSessionStatusLocal(session, hikari_session.SessionStatus.notStarted);
      } else {
        await reloadSingleModule(moduleID: moduleId);
      }
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => abortSession(moduleId: moduleId, sessionId: sessionId),
      );
    }
  }

  Future<void> abortModule({required String moduleId}) async {
    final hikari = ref.read(hikariPodProvider);

    try {
      await hikari.moduleApi.abortModule(moduleId: moduleId);
      update((state) {
        Module module = state[moduleId]!.module;

        for (Session session in module.sessions.values) {
          session = session.copyWith(
            status: hikari_session.SessionStatus.notStarted,
            completion: null,
          );
        }
        return state;
      });
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => abortModule(moduleId: moduleId));
    }
  }

  void setSessionStatusLocal(
    Session session,
    hikari_session.SessionStatus sessionStatus,
  ) {
    if (session.status == sessionStatus) {
      return;
    }
    DateTime? completion =
        sessionStatus == hikari_session.SessionStatus.finished
        ? DateTime.now()
        : null;

    if (completion != null) {
      trackEvent(
        category: TrackingCategory.session,
        action: TrackingAction.finish,
        name: "${session.module.target!.id}/${session.id}",
      );
    }

    update((state) {
      state[session.module.target!.id]!.module.sessions[session.id] = session
          .copyWith(status: sessionStatus, completion: completion);
      return state;
    });
  }
}
