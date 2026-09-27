import 'package:amsl_app/models/hikari/modules/session.dart' show SessionStatus;
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';

/// A session counts as "started" if it's not in its initial state, or if it
/// has a completion date — covering the case where a session was completed,
/// then a fresh attempt was started and aborted (which may leave status back
/// at `notStarted` without necessarily clearing `completion`). Neither case
/// should be penalized.
bool _isSessionStarted(Session session) =>
    session.status != SessionStatus.notStarted || session.completion != null;

/// Snapshot of already-loaded app data that [TranscriptCondition]s are
/// evaluated against. Built fresh each time the transcript catalog is
/// computed (see `transcript_records.dart`).
class TranscriptContext {
  final Map<String, ModuleAssessmentSet> modules;
  final Map<String, ToriAssessmentSession> assessmentSessions;
  final List<PlannerEntry> plannerEntries;
  final Map<String, PlannerMilestone> milestones;
  final Map<String, PlannerGoal> goals;
  final List<ToriJournalEntry> journalEntries;

  const TranscriptContext({
    required this.modules,
    required this.assessmentSessions,
    required this.plannerEntries,
    required this.milestones,
    required this.goals,
    required this.journalEntries,
  });
}

/// Whether [assessmentId] is a real assessment configured on any of the
/// user's modules (as their "pre" or "post" assessment) — as opposed to an
/// ID that was never wired up, which could otherwise never be completed.
bool _assessmentExists(TranscriptContext context, String assessmentId) =>
    context.modules.values.any(
      (m) => m.module.assessments?.values.contains(assessmentId) ?? false,
    );

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

/// Met when the session identified by [moduleId]/[sessionId] has a
/// completion date.
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
      context.modules[moduleId]?.module.sessions[sessionId]?.completion !=
      null;

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId] != null;
}

/// Met when the module identified by [moduleId] has a completion date
/// (i.e. all of its sessions are done).
class ModuleCompleted extends TranscriptCondition {
  final String moduleId;

  const ModuleCompleted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.modules[moduleId]?.module.completion != null;

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId] != null;
}

/// Met when the session identified by [moduleId]/[sessionId] has been
/// started (see [_isSessionStarted]).
class SessionStarted extends TranscriptCondition {
  final String moduleId;
  final String sessionId;

  const SessionStarted({
    required this.moduleId,
    required this.sessionId,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) {
    final session = context.modules[moduleId]?.module.sessions[sessionId];
    return session != null && _isSessionStarted(session);
  }

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions[sessionId] != null;
}

/// Met when any non-hidden session in the module identified by [moduleId]
/// has been started (see [_isSessionStarted]).
class ModuleStarted extends TranscriptCondition {
  final String moduleId;

  const ModuleStarted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) {
    final sessions = context.modules[moduleId]?.module.sessions.values;
    if (sessions == null) return false;
    return sessions.any((s) => !s.hide && _isSessionStarted(s));
  }

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions.values.any(
        (s) => !s.hide,
      ) ??
      false;
}

/// Met when every non-hidden session in the module identified by [moduleId]
/// has been started (see [_isSessionStarted]).
class AllSessionsStarted extends TranscriptCondition {
  final String moduleId;

  const AllSessionsStarted({required this.moduleId, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) {
    final sessions = context.modules[moduleId]?.module.sessions.values;
    if (sessions == null) return false;
    final visible = sessions.where((s) => !s.hide);
    if (visible.isEmpty) return false;
    return visible.every(_isSessionStarted);
  }

  @override
  bool existsIn(TranscriptContext context) =>
      context.modules[moduleId]?.module.sessions.values.any(
        (s) => !s.hide,
      ) ??
      false;
}

/// Met when at least one completed assessment session exists for
/// [assessmentId].
class AssessmentCompleted extends TranscriptCondition {
  final String assessmentId;

  const AssessmentCompleted({
    required this.assessmentId,
    required String label,
  }) : super(label);

  @override
  bool isMet(TranscriptContext context) => context.assessmentSessions.values
      .any((s) => s.assessmentId == assessmentId && s.completed != null);

  @override
  bool existsIn(TranscriptContext context) =>
      _assessmentExists(context, assessmentId);
}

/// Met when at least [count] planner entries have been created.
class MinPlannerEntries extends TranscriptCondition {
  final int count;

  const MinPlannerEntries({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) =>
      context.plannerEntries.length >= count;
}

/// Met when at least [count] planner milestones have been created.
class MinPlannerMilestones extends TranscriptCondition {
  final int count;

  const MinPlannerMilestones({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) => context.milestones.length >= count;
}

/// Met when at least [count] planner goals have been created.
class MinPlannerGoals extends TranscriptCondition {
  final int count;

  const MinPlannerGoals({required this.count, required String label})
    : super(label);

  @override
  bool isMet(TranscriptContext context) => context.goals.length >= count;
}

/// Met when at least [count] journal entries have been created.
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
    return completedDates.last.difference(completedDates.first) >=
        minSpacing;
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
    final dates =
        context.plannerEntries.map((e) => e.createdAt).toList()..sort();
    return dates.last.difference(dates.first) >= minSpacing;
  }
}
