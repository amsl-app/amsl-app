import 'package:amsl_app/models/tori/transcript/transcript_condition.dart';
import 'package:amsl_app/models/tori/transcript/transcript_definition.dart';

/// The catalog of transcripts of record shown in the "Leistungsnachweise"
/// screen. Edit this list to configure real module/session/assessment IDs,
/// thresholds, and copy — no other file needs to change.
///
/// TODO: move this catalog to the backend. It's hardcoded here only because
/// the backend isn't ready yet and the app needs to ship; the condition
/// evaluation logic (`transcript_condition.dart`) already works the same way
/// regardless of where the catalog data comes from, so once the backend can
/// serve `TranscriptDefinition`s, this constant should be replaced by a
/// fetch in `transcriptRecords` (`transcript_records.dart`).
const _eightWeeks = Duration(days: 56);

const List<TranscriptDefinition> transcriptCatalog = [
  TranscriptDefinition(
    id: 'onboarding_completed',
    title: 'Onboarding abgeschlossen',
    description: 'Du hast die App kennengelernt',
    conditions: [
      SessionCompleted(
        moduleId: 'onboarding',
        sessionId: 'einfuehrung',
        label: 'Onboarding abgeschlossen',
      ),
    ],
  ),
  TranscriptDefinition(
    id: 'session_module_planner_usage',
    title: 'AMSL-Nutzer',
    description:
        'Du hast die App kennengelernt und deinen Lernalltag strukturiert',
    conditions: [
      AllSessionsStarted(
        moduleId: 'lernstrategien',
        label: 'Modul "Lernstrategien" gestartet',
      ),
      AssessmentCompleted(
        assessmentId: 'LIST-K-KOG',
        label: 'Assessment zur Kognition abgeschlossen',
      ),
      AssessmentCompleted(
        assessmentId: 'LIST-K-META',
        label: 'Assessment zur Metakognition abgeschlossen',
      ),
      AssessmentCompleted(
        assessmentId: 'LIST-K-RES',
        label: 'Assessment zum Resource Management abgeschlossen',
      ),
      MinPlannerGoals(count: 1, label: '1 Ziel im Planer'),
      MinPlannerMilestones(count: 1, label: '1 Meilenstein im Planer'),
      MinPlannerEntries(count: 5, label: '5 Einträge im Planer'),
    ],
  ),
  TranscriptDefinition(
    id: 'continuous_use',
    title: 'AMSL-Experte',
    description: 'Du hast deinen Lernalltag konsequent strukturiert',
    conditions: [
      RecurringAssessment(
        assessmentId: 'LIST-K-KOG',
        minCount: 2,
        minSpacing: _eightWeeks,
        label: 'Assessment zur Kognition im Abstand von 8 Wochen wiederholt',
      ),
      RecurringAssessment(
        assessmentId: 'LIST-K-META',
        minCount: 2,
        minSpacing: _eightWeeks,
        label:
            'Assessment zur Metakognition im Abstand von 8 Wochen wiederholt',
      ),
      RecurringAssessment(
        assessmentId: 'LIST-K-RES',
        minCount: 2,
        minSpacing: _eightWeeks,
        label:
            'Assessment zum Resource Management im Abstand von 8 Wochen wiederholt',
      ),
      RecurringPlannerEntries(
        minCount: 2,
        minSpacing: _eightWeeks,
        label: 'Planer-Einträge über mind. 8 Wochen hinweg',
      ),
    ],
  ),
];
