import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';

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

/// A single unlock requirement for a transcript. [label] is the
/// user-facing checklist text; [isMet] evaluates the requirement against
/// current app state.
sealed class TranscriptCondition {
  final String label;

  const TranscriptCondition(this.label);

  bool isMet(TranscriptContext context);
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
    if (completedDates.length < minCount) return false;
    return completedDates.last.difference(completedDates.first) >=
        minSpacing;
  }
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
    if (context.plannerEntries.length < minCount) return false;
    final dates =
        context.plannerEntries.map((e) => e.effectiveDate).toList()..sort();
    return dates.last.difference(dates.first) >= minSpacing;
  }
}
