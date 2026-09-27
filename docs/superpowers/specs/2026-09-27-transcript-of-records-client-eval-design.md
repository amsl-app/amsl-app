# Transcript of Records (Leistungsnachweise) — Client-Side Condition Evaluation

Branch: `feat/transcript_of_records`
Date: 2026-09-27

## Summary

This branch already contains a first cut of the "Leistungsnachweise" feature
(see the superseded spec `2026-09-13-transcript-of-records-design.md`,
deleted in commit `2363556`): a `TranscriptRecord` model, a settings entry,
a route, a list screen/tile, and a client-side PDF exporter. That version
fetched fully-evaluated records (`unlocked` + per-requirement `met`) from a
new Hikari endpoint (`GET /transcript-records`), with an explicit non-goal
of "no client-side condition DSL or evaluation logic" — evaluation was to
live entirely server-side.

This spec **reverses that decision**: the backend endpoint doesn't exist,
and the requirement now is to evaluate unlock conditions entirely
client-side, against data the app already has locally (module/session
completion, assessment sessions, planner entries/milestones/goals, journal
entries). The catalog of transcripts and their conditions is a local Dart
constant so a developer can tune real IDs/thresholds/wording without any
backend dependency.

The UI (screen, tile, PDF export), the `TranscriptRecord`/
`TranscriptRequirement` tori models, and the settings/router wiring are
kept as-is — only the data source feeding them changes.

## Non-goals

- No backend endpoint, no network call for transcript records.
- No persistence of unlock state — conditions are recomputed from current
  provider state every time the screen builds (all underlying providers are
  `keepAlive`, so this is cheap).
- No remote/dynamic catalog (e.g. fetched or admin-editable) — the catalog
  is a compiled Dart constant, edited by developers.
- No generic condition combination logic beyond AND — a transcript unlocks
  only when every one of its conditions is met.

## Architecture

### Condition model

New file `lib/features/transcript/models/transcript_condition.dart`:

```dart
class TranscriptContext {
  final Map<String, ModuleAssessmentSet> modules;
  final Map<String, ToriAssessmentSession> assessmentSessions;
  final List<PlannerEntry> plannerEntries;
  final Map<String, PlannerMilestone> milestones;
  final Map<String, PlannerGoal> goals;
  final List<ToriJournalEntry> journalEntries;
  // ... constructor
}

sealed class TranscriptCondition {
  final String label;
  const TranscriptCondition(this.label);
  bool isMet(TranscriptContext context);
}
```

Concrete conditions (each takes its own params + a `label`):

| Class | Met when |
|---|---|
| `SessionCompleted(moduleId, sessionId)` | `modules[moduleId]?.module.sessions[sessionId]?.completion != null` |
| `ModuleCompleted(moduleId)` | `modules[moduleId]?.module.completion != null` |
| `AssessmentCompleted(assessmentId)` | any `assessmentSessions.values` with matching `assessmentId` has `completed != null` |
| `MinPlannerEntries(count)` | `plannerEntries.length >= count` (created, not necessarily completed) |
| `MinPlannerMilestones(count)` | `milestones.length >= count` |
| `MinPlannerGoals(count)` | `goals.length >= count` |
| `MinJournalEntries(count)` | `journalEntries.length >= count` |
| `RecurringAssessment(assessmentId, minCount, minSpacing)` | completed sessions matching `assessmentId`, sorted by `completed`: count `>= minCount` AND `last.completed - first.completed >= minSpacing` |
| `RecurringPlannerEntries(minCount, minSpacing)` | entries sorted by `effectiveDate`: count `>= minCount` AND `last - first >= minSpacing` |

### Catalog (the constant to edit)

New file `lib/features/transcript/transcript_catalog.dart`:

```dart
const List<TranscriptDefinition> transcriptCatalog = [
  TranscriptDefinition(
    id: 'session_module_planner_usage',
    title: 'PLACEHOLDER',
    description: 'PLACEHOLDER',
    conditions: [
      SessionCompleted(moduleId: 'PLACEHOLDER', sessionId: 'PLACEHOLDER', label: 'PLACEHOLDER'),
      MinPlannerEntries(count: 1, label: 'PLACEHOLDER'),
      MinPlannerMilestones(count: 1, label: 'PLACEHOLDER'),
      MinPlannerGoals(count: 1, label: 'PLACEHOLDER'),
    ],
  ),
  TranscriptDefinition(
    id: 'continuous_use',
    title: 'PLACEHOLDER',
    description: 'PLACEHOLDER',
    conditions: [
      RecurringAssessment(assessmentId: 'PLACEHOLDER', minCount: 2, minSpacing: Duration(days: 56), label: 'PLACEHOLDER'),
      RecurringPlannerEntries(minCount: 2, minSpacing: Duration(days: 56), label: 'PLACEHOLDER'),
    ],
  ),
];
```

`TranscriptDefinition` (new file `lib/features/transcript/models/transcript_definition.dart`) holds `id`, `title`, `description`, `conditions`.

### Provider

`lib/features/transcript/providers/transcript_records.dart` is rewritten
from a Hikari-fetching `FutureProvider` to a locally-computing one:

```dart
@Riverpod(dependencies: [ModuleNotifier, AssessmentSessions, PlannerPod, GoalPod, MilestonePod, Journal])
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

  return transcriptCatalog.map((def) {
    final requirements = def.conditions
        .map((c) => TranscriptRequirement(label: c.label, met: c.isMet(context)))
        .toList();
    return TranscriptRecord(
      id: def.id,
      title: def.title,
      description: def.description,
      unlocked: requirements.every((r) => r.met),
      requirements: requirements,
    );
  }).toList();
}
```

No error handling beyond what the underlying providers already raise (they
throw `HikariException` on fetch failure, surfaced via the existing
`AsyncValueExtension` error path in `TranscriptScreen` — unchanged).

### Removed (dead once this lands — no backend endpoint exists for it)

- `lib/hikari/apis/hikari_transcript_api.dart`
- `lib/models/hikari/transcript/` (all 3 files)
- `transcriptApi` field + import in `lib/hikari/hikari.dart`
- `TranscriptRecord.fromHikari` / `TranscriptRequirement.fromHikari` in
  `lib/models/tori/transcript/transcript_record.dart` (model shape itself
  is unchanged, just loses the now-unused hikari-mapping factories and
  their import)

### Unchanged

- `lib/features/transcript/widgets/screens/transcript_screen.dart`
- `lib/features/transcript/widgets/transcript_record_tile.dart`
- `lib/features/transcript/repository/transcript_pdf_generator.dart`
- Settings button + route (label stays "Leistungsnachweise" per user
  decision)

## Testing

No test infrastructure exists in this repo (consistent with the superseded
spec's note). Verification is `flutter analyze` plus manual smoke testing:
toggle placeholder condition values against real local state (complete a
session/module, add planner entries/milestones/goals, complete an
assessment) and confirm a transcript's requirements flip from unmet to met
and the tile unlocks with a working PDF export.
