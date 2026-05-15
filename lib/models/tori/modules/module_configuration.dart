import 'dart:collection';

import 'package:amsl_app/models/tori/modules/module_group.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../hikari/modules/module_category.dart';
import '../../hikari/modules/session.dart' as hikari_session;
import 'module_assessment.dart';

part 'module_configuration.freezed.dart';

@freezed
abstract class ModuleConfiguration with _$ModuleConfiguration {
  static final log = Logger("ModuleConfiguration");

  factory ModuleConfiguration({
    required Map<ModuleCategory, List<ModuleAssessmentSet>> modules,
    required Map<String, ModuleGroup> groups,
  }) = _ModuleConfiguration;

  ModuleConfiguration._();

  Iterable<ModuleAssessmentSet> get allModules =>
      modules.values.expand((element) => element);

  Iterable<Session> get allSessions =>
      allModules.expand((module) => module.module.sessions.values);

  Iterable<Session> get lockedSessions =>
      allSessions.where((session) => !session.unlocked);

  Iterable<Session> get unlockedSessions =>
      allSessions.where((session) => session.unlocked);

  Iterable<ModuleAssessmentSet> get shownModules =>
      allModules.where((module) => !module.module.hide);

  Iterable<(ModuleGroup, List<ModuleAssessmentSet>)> get groupedShownModules =>
      _buildGroups(shownModules);

  List<ModuleAssessmentSet> get onboardingModules =>
      modules[ModuleCategory.onboarding] ?? [];

  List<ModuleAssessmentSet> get journalModules =>
      modules[ModuleCategory.journal] ?? [];

  List<ModuleAssessmentSet> get quizzableModules => allModules
      .where((module) => module.module.quizzable)
      .toList(growable: false);

  ModuleAssessmentSet? get onboarding => onboardingModules.firstOrNull;

  ModuleAssessmentSet? get journal => journalModules.sorted((a, b) {
    return b.module.weight.compareTo(
      a.module.weight,
    ); // Sort by weight descending
  }).firstOrNull;

  Session? get runningJournalSession {
    return journal?.module.sessions.values.firstWhereOrNull(
      (element) => element.status == hikari_session.SessionStatus.started,
    );
  }

  Session? get nextJournalSession => journal?.module.sessions.values
      .firstWhereOrNull((Session session) => session.completion == null);

  DateTime? get lastModuleDone {
    DateTime? lastModuleDone;
    for (final module in allModules) {
      if (module.isDone) {
        lastModuleDone ??= module.completion!;
        if (module.completion!.isAfter(lastModuleDone)) {
          lastModuleDone = module.completion!;
        }
      }
    }
    return lastModuleDone;
  }

  Iterable<(ModuleGroup, List<ModuleAssessmentSet>)> _buildGroups(
    Iterable<ModuleAssessmentSet> modules,
  ) {
    Map<ModuleGroup, List<ModuleAssessmentSet>> modulesByGroup = HashMap();

    for (ModuleAssessmentSet module in modules) {
      for (String group in module.module.groups) {
        final modulesInGroup = modulesByGroup.putIfAbsent(
          groups[group]!,
          () => [],
        );
        modulesInGroup.add(module);
      }
    }
    return modulesByGroup.entries
        .map((e) => (e.key, e.value))
        .sortedBy<num>((element) => -element.$1.weight);
  }
}
