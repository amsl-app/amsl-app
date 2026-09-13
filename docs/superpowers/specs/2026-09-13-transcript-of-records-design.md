# Transcript of Records (Leistungsnachweis) — Design

Branch: `feat/transcript_of_records`
Date: 2026-09-13

## Summary

Add a "Leistungsnachweis" section to the profile view. Each Leistungsnachweis
is a catalog entry (title, description, unlock requirements) that becomes
unlockable once backend-evaluated conditions are met (e.g. a module
completed, the planner has N entries, N days between first/last planner
entry, an assessment session completed). Once unlocked, the user can export
it as a PDF containing their user id, the title, and the description.

This is the first of what will become multiple such catalog entries /
condition types ("integrating more tools" in the future), so the catalog is
modeled as a list from day one, and the condition-evaluation logic is kept
entirely server-side so new condition types never require an app update.

## Non-goals

- No client-side condition DSL or evaluation logic. The backend (Hikari)
  owns evaluating requirements (counts, time spans, completion checks) and
  hands the client only the result.
- No server-side PDF generation in this iteration — the PDF is rendered
  client-side.
- No new backend implementation happens in this repo. This spec defines the
  API contract the Flutter client expects; the Hikari backend team
  implements it separately. Until it exists, the feature is wired but
  non-functional against a real backend.

## Architecture

New feature folder `lib/features/transcript/`, following the standard
feature structure (`models/`, `providers/`, `repository/`, `widgets/` with
`widgets/screens/`) documented in AGENTS.md.

### Models

- `lib/models/hikari/transcript/transcript_record.dart` — raw API model
  (`@JsonSerializable`), matching the wire format below.
- `lib/models/tori/transcript/transcript_record.dart` — app-facing model,
  constructed via `TranscriptRecord.fromHikari(...)` per the existing
  hikari→tori convention (e.g. `Module.fromHikari`).

### API contract (new Hikari endpoint, not yet implemented backend-side)

```
GET /api/v0/transcript-records

Response: 200 OK
[
  {
    "id": "string",
    "title": "string",
    "description": "string",
    "unlocked": true,
    "requirements": [
      { "label": "2 Planer-Einträge", "met": true },
      { "label": "Modul \"Einführung\" abgeschlossen", "met": false }
    ]
  }
]
```

The client never interprets *what* a requirement means — it only renders
`label` + `met`. All condition types (entry counts, date spans, module/
session/assessment completion, and any future condition) live entirely in
the backend's evaluation logic.

### Hikari API layer

- `lib/hikari/apis/hikari_transcript_api.dart` — new `HikariTranscriptApi`
  with `Future<List<TranscriptRecord>> getTranscriptRecords()`, following
  the existing per-domain API class pattern (see
  `hikari_planner_api.dart`).
- Registered on the `Hikari` facade (`lib/hikari/hikari.dart`) as
  `transcriptApi`, alongside `assessmentApi`, `journalApi`, etc.

### Providers

- `lib/features/transcript/providers/transcript_records.dart` —
  `@Riverpod(dependencies: [HikariPod])` `FutureProvider`-style provider
  (not `keepAlive`) fetching the catalog fresh on each screen visit, since
  unlock state changes as the user progresses. Mirrors
  `moduleConfigurationProviderProvider`'s dependency wiring.

### UI

- `lib/features/transcript/widgets/screens/transcript_screen.dart` — list
  screen, using the existing `AsyncValueExtension.build()` loading/error/
  data pattern (see `pdf_screen.dart`, `profile_screen.dart`).
- `lib/features/transcript/widgets/transcript_record_tile.dart` — one card
  per catalog entry:
  - **Locked**: dimmed, shows the requirement checklist with ✓/✗ icons per
    `TranscriptRequirement.met`.
  - **Unlocked**: normal styling, title + description + an export button.

### Entry point

- New `SettingsButton` in
  `lib/features/profile/widgets/screens/settings.dart`, labeled
  "Leistungsnachweise" (icon: `Icons.workspace_premium_outlined`),
  navigating via `context.goNamed('transcript_records')`.
- New `GoRoute` in `lib/router.dart` registered alongside the other profile
  settings screens (`focus_settings`, `notification_settings`,
  `profile_settings`).

### PDF generation (client-side)

- `lib/features/transcript/repository/transcript_pdf_generator.dart` —
  `TranscriptPdfGenerator.exportRecord(TranscriptRecord record, User user)`,
  modeled directly on `lib/features/journal/pdf/pdf_generator.dart`:
  - Builds a `pw.Document` with the AMSL logo (same SVG asset as journal
    PDFs), the record's `title`, `description`, the current user's
    `user.id`, and an export date (`kNewDateTimeFormat.format(DateTime.now())`).
  - Saves to the app documents directory as `${record.id}.pdf`, opens it via
    `OpenFile.open`, then deletes the local copy — identical lifecycle to
    `PdfGenerator.exportSinglePdf`.
  - Export is only reachable from an unlocked tile's button, so no
    "not unlocked" error path is needed.

## Error handling

- Catalog fetch failure → standard `errorBuilder` path via
  `AsyncValueExtension`/`ErrorBar`, same as existing screens. No new error
  handling needed.
- No offline/retry logic beyond what `HikariApiClient` already provides
  globally (token refresh, retry-on-401 via `AuthController`).

## Testing

This repo currently has no `test/` directory and no mocking library
(`mockito`/`get_it`) in `pubspec.yaml` — no feature in the codebase has
automated tests today. Bootstrapping test infrastructure is out of scope
for this feature; verification is `flutter analyze` plus manual smoke
testing in a running app, consistent with existing precedent (e.g.
`journal/pdf/pdf_generator.dart` has no test coverage either).

## Open item for backend coordination

The `GET /api/v0/transcript-records` contract above needs to be agreed with
whoever implements the Hikari-side evaluation logic (entry counts, date
spans between first/last planner entry, assessment/module/session
completion). This spec only commits the Flutter client to that shape.
