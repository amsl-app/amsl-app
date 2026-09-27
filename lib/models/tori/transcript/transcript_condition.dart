import 'package:amsl_app/models/tori/assessments/assessment.dart';
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';

/// Snapshot of already-loaded app data that [TranscriptCondition]s are
/// evaluated against. Built fresh each time the transcript catalog is
/// computed (see `transcript_records.dart`).
class TranscriptContext {
  final Map<String, ModuleAssessmentSet> modules;
  final Map<String, ToriAssessmentSession> assessmentSessions;
  final Map<String, Assessment> assessments;
  final List<PlannerEntry> plannerEntries;
  final Map<String, PlannerMilestone> milestones;
  final Map<String, PlannerGoal> goals;
  final List<ToriJournalEntry> journalEntries;

  const TranscriptContext({
    required this.modules,
    required this.assessmentSessions,
    required this.assessments,
    required this.plannerEntries,
    required this.milestones,
    required this.goals,
    required this.journalEntries,
  });
}

/// Whether [assessmentId] is a real, non-hidden assessment known to the
/// backend's assessment catalog — as opposed to an ID that was never wired
/// up, which could otherwise never be completed.
bool _assessmentExists(TranscriptContext context, String assessmentId) {
  final assessment = context.assessments[assessmentId];
  return assessment != null && !assessment.hidden;
}

/// The non-hidden sessions of the module identified by [moduleId], or null
/// if that module doesn't exist.
Iterable<Session>? _visibleSessions(
  TranscriptContext context,
  String moduleId,
) => context.modules[moduleId]?.module.sessions.values.where((s) => !s.hide);

/// A single unlock requirement for a transcript. [label] is the
/// user-facing checklist text; [isMet] evaluates the requirement against
/// current app state.
///
/// [existsIn] answers a different question: does the module/session/
/// assessment this condition refers to actually exist for the user? A
/// condition can be unmet (not yet achieved) while still existing; but if
/// it references something that isn't there at all (e.g. a moduleId that
/// doesn't match any of the user's modules), it can never be fulfilled —
/// see `transcriptRecords` in `transcript_records.dart`, which hides a
/// whole transcript definition when any of its conditions don't exist,
/// rather than showing a permanently-locked, frustrating entry.
sealed class TranscriptCondition {
  final String label;

  const TranscriptCondition(this.label);

  bool isMet(TranscriptContext context);

  bool existsIn(TranscriptContext context) => true;
}

class SessionCompleted extends TranscriptCondition {
  final String moduleId;
  final String sessionId;

  const SessionCompleted({
    required this.moduleId,
    required this.sessionId,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId]?.completion != null;

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId] != null;
}

class ModuleCompleted extends TranscriptCondition {
  final String moduleId;

  const ModuleCompleted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.modules[moduleId]?.module.completion != null;

  @override
  bool existsIn(TranscriptContext context) => context.modules[moduleId] != null;
}

/// Met when the session identified by [moduleId]/[sessionId] has been
/// started (see [Session.started]).
class SessionStarted extends TranscriptCondition {
  final String moduleId;
  final String sessionId;

  const SessionStarted({
    required this.moduleId,
    required this.sessionId,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId]?.started ?? false;

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId] != null;
}

/// Met when any non-hidden session in the module identified by [moduleId]
/// has been started.
class ModuleStarted extends TranscriptCondition {
  final String moduleId;

  const ModuleStarted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      _visibleSessions(context, moduleId)?.any((s) => s.started) ?? false;

  @override
  bool existsIn(TranscriptContext context) =>
      _visibleSessions(context, moduleId)?.isNotEmpty ?? false;
}

/// Met when every non-hidden session in the module identified by [moduleId]
/// has been started.
class AllSessionsStarted extends TranscriptCondition {
  final String moduleId;

  const AllSessionsStarted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) {
    final visible = _visibleSessions(context, moduleId);
    if (visible == null || visible.isEmpty) return false;
    return visible.every((s) => s.started);
  }

  @override
  bool existsIn(TranscriptContext context) =>
      _visibleSessions(context, moduleId)?.isNotEmpty ?? false;
}

/// Met when at least one completed assessment session exists for
/// [assessmentId].
class AssessmentCompleted extends TranscriptCondition {
  final String assessmentId;

  const AssessmentCompleted({required this.assessmentId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) => context.assessmentSessions.values
      .any((s) => s.assessmentId == assessmentId && s.completed != null);

  @override
  bool existsIn(TranscriptContext context) =>
      _assessmentExists(context, assessmentId);
}

class MinPlannerEntries extends TranscriptCondition {
  final int count;

  const MinPlannerEntries({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.plannerEntries.length >= count;
}

class MinPlannerMilestones extends TranscriptCondition {
  final int count;

  const MinPlannerMilestones({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) => context.milestones.length >= count;
}

class MinPlannerGoals extends TranscriptCondition {
  final int count;

  const MinPlannerGoals({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) => context.goals.length >= count;
}

class MinJournalEntries extends TranscriptCondition {
  final int count;

  const MinJournalEntries({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.journalEntries.length >= count;
}

/// Met when at least [minCount] completed assessment sessions exist for
/// [assessmentId], spanning at least [minSpacing] between the earliest and
/// latest completion.
class RecurringAssessment extends TranscriptCondition {
  final String assessmentId;
  final int minCount;
  final Duration minSpacing;

  const RecurringAssessment({
    required this.assessmentId,
    required this.minCount,
    required this.minSpacing,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) {
    final completedDates =
        context.assessmentSessions.values
            .where((s) => s.assessmentId == assessmentId && s.completed != null)
            .map((s) => s.completed!)
            .toList()
          ..sort();
    if (completedDates.isEmpty || completedDates.length < minCount) {
      return false;
    }
    return completedDates.last.difference(completedDates.first) >= minSpacing;
  }

  @override
  bool existsIn(TranscriptContext context) =>
      _assessmentExists(context, assessmentId);
}

/// Met when at least [minCount] planner entries exist, spanning at least
/// [minSpacing] between the earliest and latest effective date.
class RecurringPlannerEntries extends TranscriptCondition {
  final int minCount;
  final Duration minSpacing;

  const RecurringPlannerEntries({
    required this.minCount,
    required this.minSpacing,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) {
    if (context.plannerEntries.isEmpty ||
        context.plannerEntries.length < minCount) {
      return false;
    }
    final dates = context.plannerEntries.map((e) => e.createdAt).toList()
      ..sort();
    return dates.last.difference(dates.first) >= minSpacing;
  }
}
