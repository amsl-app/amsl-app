import 'package:amsl_app/models/tori/modules/module_assessment.dart';

import '../assessments/assessment_session.dart';
import '../modules/session.dart';

sealed class HistoryEntry {
  final DateTime completed;

  const HistoryEntry({required this.completed});
}

class AssessmentHistory extends HistoryEntry {
  final String assessmentId;
  final ToriAssessmentSession? assessmentSession;

  AssessmentHistory({
    required this.assessmentId,
    required this.assessmentSession,
    required super.completed,
  });
}

class ModuleHistory extends HistoryEntry {
  final String? moduleId;
  final ModuleAssessmentSet? module;

  ModuleHistory({
    required this.moduleId,
    required this.module,
    required super.completed,
  });
}

class SessionHistory extends HistoryEntry {
  final String? moduleId;
  final String? sessionId;
  final ModuleAssessmentSet? module;
  final Session? session;

  SessionHistory({
    required this.moduleId,
    required this.sessionId,
    required this.module,
    required this.session,
    required super.completed,
  });
}
