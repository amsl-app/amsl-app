import 'package:amsl_app/features/transcript/models/transcript_condition.dart';
import 'package:amsl_app/features/transcript/models/transcript_definition.dart';

/// The catalog of transcripts of record shown in the "Leistungsnachweise"
/// screen. Edit this list to configure real module/session/assessment IDs,
/// thresholds, and copy — no other file needs to change.
const List<TranscriptDefinition> transcriptCatalog = [
  TranscriptDefinition(
    id: 'session_module_planner_usage',
    title: 'PLACEHOLDER_TITLE_1',
    description: 'PLACEHOLDER_DESCRIPTION_1',
    conditions: [
      SessionCompleted(
        moduleId: 'PLACEHOLDER_MODULE_ID',
        sessionId: 'PLACEHOLDER_SESSION_ID',
        label: 'PLACEHOLDER_LABEL_SESSION_COMPLETED',
      ),
      MinPlannerEntries(count: 1, label: 'PLACEHOLDER_LABEL_PLANNER_ENTRIES'),
      MinPlannerMilestones(
        count: 1,
        label: 'PLACEHOLDER_LABEL_PLANNER_MILESTONES',
      ),
      MinPlannerGoals(count: 1, label: 'PLACEHOLDER_LABEL_PLANNER_GOALS'),
    ],
  ),
  TranscriptDefinition(
    id: 'continuous_use',
    title: 'PLACEHOLDER_TITLE_2',
    description: 'PLACEHOLDER_DESCRIPTION_2',
    conditions: [
      RecurringAssessment(
        assessmentId: 'PLACEHOLDER_ASSESSMENT_ID',
        minCount: 2,
        minSpacing: Duration(days: 56),
        label: 'PLACEHOLDER_LABEL_RECURRING_ASSESSMENT',
      ),
      RecurringPlannerEntries(
        minCount: 2,
        minSpacing: Duration(days: 56),
        label: 'PLACEHOLDER_LABEL_RECURRING_PLANNER_ENTRIES',
      ),
    ],
  ),
];
