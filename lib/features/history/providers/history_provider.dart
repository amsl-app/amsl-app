import 'dart:async';

import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/exception.dart';
import '../../../hikari/hikari.dart';
import '../../../models/hikari/history/history_model.dart';
import '../../../models/tori/assessments/assessment_session.dart';
import '../../../models/tori/history/history_entry.dart';
import '../../assessment/providers/assessment_sessions.dart';
import '../../modules/providers/module_provider.dart';

part 'history_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [HikariPod, AssessmentSessions, ModuleNotifier],
)
class HistoryProvider extends _$HistoryProvider {
  static final log = Logger("History");

  @override
  Future<List<HistoryEntry>> build() async {
    final hikari = ref.watch(hikariPodProvider);

    return _loadHistoryFromApi(hikari);
  }

  Future<List<HistoryEntry>> _loadHistoryFromApi(Hikari hikari) async {
    final assessmentSessionsFuture = ref.watch(
      assessmentSessionsProvider.future,
    );
    final moduleFuture = ref.watch(moduleProvider.future);
    // Don't watch/read from ref in parallel (causes errors)

    final result = await Future.wait([
      assessmentSessionsFuture,
      moduleFuture,
      () async {
        try {
          return hikari.moduleApi.getHistory();
        } on HikariException catch (e) {
          throw e.copyWith(resolve: reloadHistory);
        }
      }(),
    ]);

    final assessmentSessions = result[0] as Map<String, ToriAssessmentSession>;
    final modules = result[1] as Map<String, ModuleAssessmentSet>;
    final List<HistoryModel> historyModel = result[2] as List<HistoryModel>;

    log.info(
      "Loaded modules: ${modules.length}, Loaded assessmentSessions: ${assessmentSessions.length}, Loaded historyModel: ${historyModel.length}",
    );

    final allItems = historyModel
        .map((e) => _createHistoryEntry(e, modules, assessmentSessions))
        .toList();

    return allItems.whereType<HistoryEntry>().toList();
  }

  Future<List<HistoryEntry>> reloadHistory({bool complete = false}) async {
    if (complete) {
      ref.read(moduleProvider.notifier).reloadModules(complete: true);
    } else {
      ref.invalidateSelf();
    }
    return future;
  }

  HistoryEntry _createHistoryEntry(
    HistoryModel historyItem,
    Map<String, ModuleAssessmentSet> modules,
    Map<String, ToriAssessmentSession> assessments,
  ) {
    switch (historyItem) {
      case AssessmentHistoryModel():
        final assessmentSession = assessments[historyItem.sessionId];
        return AssessmentHistory(
          assessmentSession: assessmentSession,
          completed: historyItem.completed,
          assessmentId: historyItem.sessionId,
        );
      case ModuleHistoryModel():
        final module = modules[historyItem.module];
        return ModuleHistory(
          module: module,
          completed: historyItem.completed,
          moduleId: historyItem.module,
        );
      case SessionHistoryModel():
        final module = modules[historyItem.module];
        final session = module?.module.sessions[historyItem.session];
        return SessionHistory(
          module: module,
          session: session,
          completed: historyItem.completed,
          moduleId: historyItem.module,
          sessionId: historyItem.session,
        );
    }
  }
}
