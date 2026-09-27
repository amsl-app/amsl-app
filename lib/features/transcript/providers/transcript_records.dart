import 'package:amsl_app/features/assessment/providers/assessment_sessions.dart';
import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/modules/providers/module_provider.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/transcript/models/transcript_condition.dart';
import 'package:amsl_app/features/transcript/transcript_catalog.dart';
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/models/tori/transcript/transcript_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_records.g.dart';

/// Evaluates [transcriptCatalog] against currently-loaded app state. No
/// network call — every dependency here is a `keepAlive` provider already
/// populated for the rest of the app.
@Riverpod(
  dependencies: [
    ModuleNotifier,
    AssessmentSessions,
    PlannerPod,
    GoalPod,
    MilestonePod,
    Journal,
  ],
)
Future<List<TranscriptRecord>> transcriptRecords(Ref ref) async {
  final results = await Future.wait([
    ref.watch(moduleProvider.future),
    ref.watch(assessmentSessionsProvider.future),
    ref.watch(plannerPodProvider.future),
    ref.watch(goalPodProvider.future),
    ref.watch(milestonePodProvider.future),
    ref.watch(journalProvider.future),
  ]);

  final context = TranscriptContext(
    modules: results[0] as Map<String, ModuleAssessmentSet>,
    assessmentSessions: results[1] as Map<String, ToriAssessmentSession>,
    plannerEntries: results[2] as List<PlannerEntry>,
    goals: results[3] as Map<String, PlannerGoal>,
    milestones: results[4] as Map<String, PlannerMilestone>,
    journalEntries: results[5] as List<ToriJournalEntry>,
  );

  return transcriptCatalog.map((definition) {
    final requirements = definition.conditions
        .map(
          (condition) => TranscriptRequirement(
            label: condition.label,
            met: condition.isMet(context),
          ),
        )
        .toList();
    return TranscriptRecord(
      id: definition.id,
      title: definition.title,
      description: definition.description,
      unlocked: requirements.every((r) => r.met),
      requirements: requirements,
    );
  }).toList();
}
