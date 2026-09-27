import 'package:amsl_app/features/assessment/providers/assessment_sessions.dart';
import 'package:amsl_app/features/assessment/providers/assessments.dart';
import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/modules/providers/module_provider.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/transcript/models/transcript_condition.dart';
import 'package:amsl_app/features/transcript/transcript_catalog.dart';
import 'package:amsl_app/models/tori/transcript/transcript_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_records.g.dart';

/// Evaluates [transcriptCatalog] against currently-loaded app state. No
/// dedicated transcript-records network call — this reuses the app's
/// existing `keepAlive` providers, each of which fetches from Hikari on
/// its own first use and is cached afterward. Awaiting all seven means any
/// one of them failing surfaces as an error for this whole screen
/// (consistent with how `moduleProvider` itself already composes multiple
/// providers) rather than degrading per-condition.
@Riverpod(
  dependencies: [
    ModuleNotifier,
    AssessmentSessions,
    AssessmentPod,
    PlannerPod,
    GoalPod,
    MilestonePod,
    Journal,
  ],
)
Future<List<TranscriptRecord>> transcriptRecords(Ref ref) async {
  final modulesFuture = ref.watch(moduleProvider.future);
  final assessmentSessionsFuture = ref.watch(assessmentSessionsProvider.future);
  final assessmentConfigurationFuture = ref.watch(assessmentPodProvider.future);
  final plannerEntriesFuture = ref.watch(plannerPodProvider.future);
  final goalsFuture = ref.watch(goalPodProvider.future);
  final milestonesFuture = ref.watch(milestonePodProvider.future);
  final journalEntriesFuture = ref.watch(journalProvider.future);

  final context = TranscriptContext(
    modules: await modulesFuture,
    assessmentSessions: await assessmentSessionsFuture,
    assessments: (await assessmentConfigurationFuture).assessments,
    plannerEntries: await plannerEntriesFuture,
    goals: await goalsFuture,
    milestones: await milestonesFuture,
    journalEntries: await journalEntriesFuture,
  );

  // Hide definitions with unresolvable conditions — see TranscriptCondition.existsIn.
  return transcriptCatalog
      .where(
        (definition) => definition.conditions.every(
          (condition) => condition.existsIn(context),
        ),
      )
      .map((definition) {
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
      })
      .toList();
}
