# Transcript of Records Client-Side Evaluation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the backend-fetched "Leistungsnachweise" (transcript of records) catalog with a locally-evaluated one, driven by a developer-editable Dart constant, so unlock state is computed entirely from data the app already has (module/session completion, assessment sessions, planner entries/milestones/goals, journal entries).

**Architecture:** A sealed `TranscriptCondition` class family evaluates boolean checks against a `TranscriptContext` snapshot of already-loaded provider data. A constant `transcriptCatalog` list of `TranscriptDefinition`s (title/description/conditions, currently placeholders) is mapped into `TranscriptRecord`s by a rewritten `transcriptRecordsProvider` that no longer talks to Hikari. The now-dead Hikari transcript API/model layer is removed. The existing screen, tile, and PDF exporter are untouched.

**Tech Stack:** Flutter, Riverpod (`riverpod_annotation` codegen), Dart (no new packages).

**Spec:** `docs/superpowers/specs/2026-09-27-transcript-of-records-client-eval-design.md`

## Global Constraints

- No backend network call for transcript records — everything is computed from already-loaded local providers.
- A transcript record's `unlocked` is `true` only when every one of its `conditions` is met (AND).
- The catalog (`transcriptCatalog`) is the single place a developer edits real IDs/thresholds/labels — no other file should need touching to configure a transcript.
- `TranscriptRecord`/`TranscriptRequirement` (`lib/models/tori/transcript/transcript_record.dart`) keep their existing field shape (`id`, `title`, `description`, `unlocked`, `requirements: [{label, met}]`) — the screen and tile read these unchanged.
- No test infrastructure exists in this repo (no `test/` directory) — verification per task is `flutter analyze` plus, where noted, a manual smoke-test description. Do not add a test framework or `test/` directory as part of this plan.
- Settings label stays "Leistungsnachweise" (user decision — no copy change).

---

### Task 1: Transcript condition model

**Files:**
- Create: `lib/features/transcript/models/transcript_condition.dart`

**Interfaces:**
- Consumes: `ModuleAssessmentSet` (`lib/models/tori/modules/module_assessment.dart`, field `module: Module`), `Module` (`lib/models/tori/modules/module.dart`, fields `sessions: ListMap<String, Session>`, `completion: DateTime?`), `Session` (`lib/models/tori/modules/session.dart`, field `completion: DateTime?`), `ToriAssessmentSession` (`lib/models/tori/assessments/assessment_session.dart`, fields `assessmentId: String`, `completed: DateTime?`), `PlannerEntry` (`lib/models/tori/planner/planner_entry.dart`, field `effectiveDate: DateTime`), `PlannerGoal` (`lib/models/tori/planner/planner_goal.dart`), `PlannerMilestone` (`lib/models/tori/planner/planner_milestone.dart`), `ToriJournalEntry` (`lib/models/tori/journal/journal_entry.dart`).
- Produces: `TranscriptContext` (named constructor with fields `modules`, `assessmentSessions`, `plannerEntries`, `milestones`, `goals`, `journalEntries`) and the sealed `TranscriptCondition` class plus 9 concrete subclasses (`SessionCompleted`, `ModuleCompleted`, `AssessmentCompleted`, `MinPlannerEntries`, `MinPlannerMilestones`, `MinPlannerGoals`, `MinJournalEntries`, `RecurringAssessment`, `RecurringPlannerEntries`) — used by Task 3 (catalog) and Task 4 (provider).

- [ ] **Step 1: Write the file**

```dart
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
```

- [ ] **Step 2: Verify it analyzes cleanly**

Run: `flutter analyze lib/features/transcript/models/transcript_condition.dart`
Expected: `No issues found!`

- [ ] **Step 3: Commit**

```bash
git add lib/features/transcript/models/transcript_condition.dart
git commit -m "$(cat <<'EOF'
feat: add transcript condition types for local unlock evaluation

Assisted-by: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Task 2: TranscriptDefinition model

**Files:**
- Create: `lib/features/transcript/models/transcript_definition.dart`

**Interfaces:**
- Consumes: `TranscriptCondition` from Task 1 (`lib/features/transcript/models/transcript_condition.dart`).
- Produces: `TranscriptDefinition` (fields `id: String`, `title: String`, `description: String`, `conditions: List<TranscriptCondition>`) — used by Task 3 (catalog) and Task 4 (provider).

- [ ] **Step 1: Write the file**

```dart
import 'package:amsl_app/features/transcript/models/transcript_condition.dart';

/// A single catalog entry: what it's called, and the conditions that must
/// all be met (AND) for it to unlock. See `transcript_catalog.dart` for the
/// actual list — this is just the shape.
class TranscriptDefinition {
  final String id;
  final String title;
  final String description;
  final List<TranscriptCondition> conditions;

  const TranscriptDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.conditions,
  });
}
```

- [ ] **Step 2: Verify it analyzes cleanly**

Run: `flutter analyze lib/features/transcript/models/transcript_definition.dart`
Expected: `No issues found!`

- [ ] **Step 3: Commit**

```bash
git add lib/features/transcript/models/transcript_definition.dart
git commit -m "$(cat <<'EOF'
feat: add TranscriptDefinition catalog entry model

Assisted-by: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Task 3: Transcript catalog constant

**Files:**
- Create: `lib/features/transcript/transcript_catalog.dart`

**Interfaces:**
- Consumes: `TranscriptDefinition` (Task 2), condition classes `SessionCompleted`, `MinPlannerEntries`, `MinPlannerMilestones`, `MinPlannerGoals`, `RecurringAssessment`, `RecurringPlannerEntries` (Task 1).
- Produces: `const List<TranscriptDefinition> transcriptCatalog` — the single place a developer edits real IDs/thresholds/copy. Used by Task 4 (provider).

- [ ] **Step 1: Write the file**

```dart
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
```

- [ ] **Step 2: Verify it analyzes cleanly**

Run: `flutter analyze lib/features/transcript/transcript_catalog.dart`
Expected: `No issues found!`

- [ ] **Step 3: Commit**

```bash
git add lib/features/transcript/transcript_catalog.dart
git commit -m "$(cat <<'EOF'
feat: add transcript catalog with placeholder conditions

Assisted-by: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Task 4: Rewrite transcriptRecords provider for local evaluation

**Files:**
- Modify: `lib/features/transcript/providers/transcript_records.dart` (full rewrite of body)
- Regenerated: `lib/features/transcript/providers/transcript_records.g.dart` (via build_runner — do not hand-edit)

**Interfaces:**
- Consumes: `moduleProvider` (`lib/features/modules/providers/module_provider.dart`, `.future` resolves to `Map<String, ModuleAssessmentSet>`), `assessmentSessionsProvider` (`lib/features/assessment/providers/assessment_sessions.dart`, `.future` resolves to `Map<String, ToriAssessmentSession>`), `plannerPodProvider` (`lib/features/planner/providers/planner.dart`, `.future` resolves to `List<PlannerEntry>`), `goalPodProvider` (`lib/features/planner/providers/goals.dart`, `.future` resolves to `Map<String, PlannerGoal>`), `milestonePodProvider` (`lib/features/planner/providers/milestone.dart`, `.future` resolves to `Map<String, PlannerMilestone>`), `journalProvider` (`lib/features/journal/providers/journal.dart`, `.future` resolves to `List<ToriJournalEntry>`), `TranscriptContext` (Task 1), `transcriptCatalog` (Task 3), `TranscriptRecord`/`TranscriptRequirement` (`lib/models/tori/transcript/transcript_record.dart` — unchanged shape).
- Produces: `transcriptRecordsProvider` (same name/type as before: `FutureProvider<List<TranscriptRecord>>`) — consumed unchanged by `lib/features/transcript/widgets/screens/transcript_screen.dart`.

- [ ] **Step 1: Rewrite the file**

```dart
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
```

- [ ] **Step 2: Regenerate provider codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: build succeeds, `lib/features/transcript/providers/transcript_records.g.dart` is rewritten with `dependencies: <ProviderOrFamily>[moduleProvider, assessmentSessionsProvider, plannerPodProvider, goalPodProvider, milestonePodProvider, journalProvider]` (or equivalent transitive-dependency set) instead of `[hikariPodProvider]`.

- [ ] **Step 3: Verify it analyzes cleanly**

Run: `flutter analyze lib/features/transcript`
Expected: `No issues found!`

- [ ] **Step 4: Commit**

```bash
git add lib/features/transcript/providers/transcript_records.dart lib/features/transcript/providers/transcript_records.g.dart
git commit -m "$(cat <<'EOF'
feat: evaluate transcript records locally instead of via Hikari

Assisted-by: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Task 5: Remove dead Hikari transcript layer

**Files:**
- Delete: `lib/hikari/apis/hikari_transcript_api.dart`
- Delete: `lib/models/hikari/transcript/transcript_record.dart`
- Delete: `lib/models/hikari/transcript/transcript_record.freezed.dart`
- Delete: `lib/models/hikari/transcript/transcript_record.g.dart`
- Modify: `lib/hikari/hikari.dart`
- Modify: `lib/models/tori/transcript/transcript_record.dart`

**Interfaces:**
- Consumes: none new.
- Produces: `Hikari` facade without a `transcriptApi` field; `TranscriptRecord`/`TranscriptRequirement` tori models keep their existing freezed field shape but lose the `fromHikari` factories (nothing in the codebase calls them after Task 4).

- [ ] **Step 1: Delete the dead files**

```bash
git rm lib/hikari/apis/hikari_transcript_api.dart
git rm -r lib/models/hikari/transcript
```

- [ ] **Step 2: Remove the transcriptApi wiring from the Hikari facade**

In `lib/hikari/hikari.dart`, remove the import, field, and constructor initializer:

```dart
import 'package:amsl_app/hikari/apis/hikari_assessment_api.dart';
import 'package:amsl_app/hikari/apis/hikari_journal_api.dart';
import 'package:amsl_app/hikari/apis/hikari_planner_api.dart';
import 'package:amsl_app/hikari/apis/hikari_quiz_api.dart';
import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:logging/logging.dart';

import 'apis/hikari_module_api.dart';
import 'apis/hikari_user_api.dart';
import 'apis/hikari_util_api.dart';

class Hikari {
  static final log = Logger('hikari');
  final BaseHikariApiClient apiClient;

  final HikariAssessmentApi assessmentApi;
  final HikariJournalApi journalApi;
  final HikariModuleApi moduleApi;
  final HikariUserApi userApi;
  final HikariUtilApi utilApi;
  final HikariQuizApi quizApi;
  final HikariPlannerApi plannerApi;

  Hikari({required this.apiClient})
    : assessmentApi = HikariAssessmentApi(apiClient),
      journalApi = HikariJournalApi(apiClient),
      moduleApi = HikariModuleApi(apiClient),
      userApi = HikariUserApi(apiClient),
      utilApi = HikariUtilApi(apiClient),
      quizApi = HikariQuizApi(apiClient),
      plannerApi = HikariPlannerApi(apiClient);
}
```

- [ ] **Step 3: Drop the fromHikari factories from the tori model**

Replace the full contents of `lib/models/tori/transcript/transcript_record.dart` with:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript_record.freezed.dart';

@freezed
abstract class TranscriptRecord with _$TranscriptRecord {
  const factory TranscriptRecord({
    required String id,
    required String title,
    required String description,
    required bool unlocked,
    required List<TranscriptRequirement> requirements,
  }) = _TranscriptRecord;
}

@freezed
abstract class TranscriptRequirement with _$TranscriptRequirement {
  const factory TranscriptRequirement({
    required String label,
    required bool met,
  }) = _TranscriptRequirement;
}
```

- [ ] **Step 4: Regenerate codegen and confirm no stale references**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: build succeeds with no errors about missing `hikari_transcript` imports.

Run: `grep -rn "transcriptApi\|HikariTranscriptApi\|hikari_transcript\|fromHikari" lib/features/transcript lib/hikari/hikari.dart lib/models/tori/transcript`
Expected: no output (no remaining references).

- [ ] **Step 5: Verify the whole project analyzes cleanly**

Run: `flutter analyze`
Expected: `No issues found!`

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "$(cat <<'EOF'
refactor: remove dead Hikari transcript API and model layer

Assisted-by: Claude <noreply@anthropic.com>
EOF
)"
```

---

### Task 6: End-to-end manual verification

**Files:** none (verification only).

**Interfaces:** none.

- [ ] **Step 1: Run the app**

Run: `flutter run --flavor dev lib/main_dev.dart`

- [ ] **Step 2: Navigate to the transcript screen**

In the running app: Profile tab → "Leistungsnachweise". Confirm:
- The screen loads without a crash or error banner.
- Both catalog entries render as locked (since `PLACEHOLDER_MODULE_ID`/`PLACEHOLDER_ASSESSMENT_ID` never match real data), each showing its requirement checklist with all items unmet (empty-circle icons).
- No "Als PDF exportieren" button appears (only shown when `unlocked`).

- [ ] **Step 3: Sanity-check one condition flips when real IDs are substituted**

Temporarily edit one entry in `lib/features/transcript/transcript_catalog.dart` — set `MinPlannerEntries(count: 1, ...)`'s `count` to `0` (trivially true) — hot reload, and confirm that specific requirement's icon switches to the met (check-circle) state while the others stay unmet. Revert the edit afterward (`git checkout -- lib/features/transcript/transcript_catalog.dart`) so the committed placeholders are unchanged.

- [ ] **Step 4: Report result**

No commit for this task — it's verification only. If any step fails, stop and fix the underlying issue in the relevant earlier task before proceeding.
