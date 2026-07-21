# Planner API

Base path: `/api/v0/planner`

All endpoints except the public iCal feed (`GET /ical/{token}`) require a bearer token
(`Authorization: Bearer <token>`) and permission **`Permission::Basic`**. Endpoints that need
`Permission::Basic` are marked below; the iCal feed endpoint has no `#[protect(...)]` at all and is
intentionally unauthenticated (it's a long-lived, opaque per-user token embedded in the URL, meant
to be pasted into a calendar app).

## Data Models

Dates are `"YYYY-MM-DD"` strings (`NaiveDate`). Timestamps are ISO 8601 without a UTC offset, e.g.
`"2026-07-21T10:30:00"` (`NaiveDateTime` — treat as UTC). `id`/`milestone_id` fields are UUID strings.

### `PlannerEntry`

Returned by **create** and **update** entry endpoints. `milestone_id` is the raw foreign key —
no embedded milestone data.

| Field | Type | Nullable? | Notes |
|---|---|---|---|
| `id` | string (uuid) | no | |
| `date` | string (date) | no | |
| `title` | string | no | |
| `completed` | boolean | no | |
| `priority` | integer | no | `0`–`3` |
| `milestone_id` | string (uuid) | yes | field omitted from JSON entirely when null |
| `created_at` | string (date-time) | no | |
| `updated_at` | string (date-time) | no | |

(`user_id` exists on the Rust struct but is never serialized — don't expect it in the response.)

### `PlannerEntryFull`

Returned by the two **fetch** entry endpoints (list and get-by-id) instead of `PlannerEntry`. Same
fields, but `milestone_id` is replaced by the embedded milestone object so the client doesn't need a
second round-trip to show the milestone's title/date.

| Field | Type | Nullable? | Notes |
|---|---|---|---|
| `id` | string (uuid) | no | |
| `date` | string (date) | no | |
| `title` | string | no | |
| `completed` | boolean | no | |
| `priority` | integer | no | `0`–`3` |
| `milestone` | `PlannerMilestone` object | yes | field omitted entirely when the entry has no milestone |
| `created_at` | string (date-time) | no | |
| `updated_at` | string (date-time) | no | |

**Important:** this means the shape of a planner entry differs depending on which endpoint returned
it — `milestone_id` (string|omitted) from create/update vs. `milestone` (object|omitted) from the
fetch endpoints. Don't assume one unified "Entry" type across all requests; model them as two types,
or normalize on the client after fetching.

### `PlannerMilestone`

Returned by **create** and **update** milestone endpoints.

| Field | Type | Nullable? | Notes |
|---|---|---|---|
| `id` | string (uuid) | no | |
| `title` | string | no | |
| `date` | string (date) | no | |
| `description` | string | yes | omitted from JSON when null |
| `module_id` | string | yes | omitted from JSON when null; set only for milestones imported from a course module |
| `origin_id` | string | yes | omitted from JSON when null; the module-config id this milestone was imported from |
| `created_at` | string (date-time) | no | |
| `updated_at` | string (date-time) | no | |

### `PlannerMilestoneFull`

Returned by both **fetch** milestone endpoints (list and get-by-id) instead of `PlannerMilestone`.
Same fields, plus:

| Field | Type | Nullable? | Notes |
|---|---|---|---|
| `entries` | array of `PlannerEntry` | no (array, may be empty) | field omitted entirely from JSON when empty |

The embedded entries are plain `PlannerEntry` objects (i.e. they carry `milestone_id`, which will
equal the parent milestone's `id` — mildly redundant but harmless).

### `NewPlannerEntry` (request body)

| Field | Type | Required | Notes |
|---|---|---|---|
| `date` | string (date) | yes | |
| `title` | string | yes | trimmed server-side; 1–500 chars after trimming |
| `priority` | integer | yes | must be `0`–`3` inclusive |
| `milestone_id` | string (uuid) | no | must belong to the requesting user or the whole batch is rejected |

### `PlannerEntryChanges` (PATCH request body)

| Field | Type | Notes |
|---|---|---|
| `date` | string (date) or omitted | plain optional: omit to leave unchanged |
| `title` | string or omitted | plain optional |
| `completed` | boolean or omitted | plain optional |
| `priority` | integer or omitted | plain optional, `0`–`3` (not re-validated server-side on PATCH, unlike create) |
| `milestone_id` | **tri-state**, see below | |

**`milestone_id` is tri-state** (`Option<Option<Uuid>>` + `double_option` on the Rust side):
- Omit the key entirely → milestone is left unchanged.
- `"milestone_id": null` → clears the entry's milestone.
- `"milestone_id": "<uuid>"` → sets/changes the milestone (must belong to the user, else `404`).

### `NewPlannerMilestone` (request body)

| Field | Type | Required | Notes |
|---|---|---|---|
| `title` | string | yes | trimmed server-side; 1–500 chars after trimming |
| `date` | string (date) | yes | |
| `description` | string | no | |

### `PlannerMilestoneChanges` (PATCH request body)

| Field | Type | Notes |
|---|---|---|
| `title` | string or omitted | plain optional; re-validated (1–500 chars) if present |
| `date` | string (date) or omitted | plain optional |
| `description` | **tri-state**, see below | |

**`description` is tri-state** (`Option<Option<String>>` + `double_option`):
- Omit the key → description left unchanged.
- `"description": null` → clears it.
- `"description": "text"` → sets it.

### `PlannerIcalToken`

| Field | Type | Notes |
|---|---|---|
| `token` | string | opaque token; embed in the iCal feed URL |

### `PlannerAssistantRequest` (request body)

| Field | Type | Required | Notes |
|---|---|---|---|
| `text` | string | yes | free text to parse into entries |
| `today` | string (date) | no | client's local "today", for resolving "tomorrow" etc.; falls back to server UTC date if omitted |

---

## Endpoints

### List planner entries — `get_planner_entries`

`GET /api/v0/planner/entries`

- **Auth:** `Permission::Basic`
- **Query params:**
  - `from` (date, optional) — only entries on/after this date (inclusive)
  - `to` (date, optional) — only entries on/before this date (inclusive)
- **Response `200`:** `PlannerEntryFull[]`, sorted by date descending.

### Get a planner entry — `get_planner_entry`

`GET /api/v0/planner/entries/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Response `200`:** `PlannerEntryFull`
- **Errors:** `404` (no body) if not found or not owned by the caller.

### Create planner entries — `create_planner_entries`

`POST /api/v0/planner/entries`

- **Auth:** `Permission::Basic`
- **Request body:** `NewPlannerEntry[]` (bulk create; can be a single-element array)
- **Response `201`:** `PlannerEntry[]`, same order as the request.
- **Errors:**
  - `422` (no body — the validation message is logged server-side only, never returned to the
    client) if any entry fails validation (empty/oversized title, priority out of `0..=3`). The
    whole batch is rejected, not just the bad entry.
  - `404` (no body) if any `milestone_id` in the batch doesn't exist or isn't owned by the caller.

### Update a planner entry — `update_planner_entry`

`PATCH /api/v0/planner/entries/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Request body:** `PlannerEntryChanges` — remember `milestone_id`'s tri-state semantics.
- **Response `200`:** `PlannerEntry`
- **Errors:** `404` (no body) if the entry isn't found/owned, or if a new `milestone_id` doesn't
  exist/isn't owned by the caller.

### Delete a planner entry — `delete_planner_entry`

`DELETE /api/v0/planner/entries/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Response `204`:** no body.
- **Errors:** `404` (no body) if not found/owned.

### Get or create the iCal feed token — `get_ical_token`

`GET /api/v0/planner/ical-token`

- **Auth:** `Permission::Basic`
- **Response `200`:** `PlannerIcalToken`. Idempotent — creates the token on first call, returns the
  same one afterwards.

### Revoke the iCal feed token — `delete_ical_token`

`DELETE /api/v0/planner/ical-token`

- **Auth:** `Permission::Basic`
- **Response `204`:** no body. Invalidates the existing feed URL; a later `GET` mints a new token.

### iCal feed — `get_planner_ical`

`GET /api/v0/planner/ical/{token}`

- **Auth:** none — unauthenticated by design (no `#[protect]` on this handler). Access is gated
  purely by knowledge of the opaque `token` path segment.
- **Path params:** `token` (string, from `PlannerIcalToken.token`)
- **Response `200`:** **not JSON** — `Content-Type: text/calendar; charset=utf-8`, an RFC 5545
  `VCALENDAR` document covering all of the token owner's entries. Fetch as raw text.
- **Errors:** `404` (no body) if the token is invalid/revoked.

### List milestones — `get_milestones`

`GET /api/v0/planner/milestones`

- **Auth:** `Permission::Basic`
- **Query params:** `deep` (optional, presence-based — any value, e.g. `?deep=true` or even
  `?deep=`, counts as "set"; omit the param entirely for shallow) — if set, each milestone's
  `entries` array is populated in the same response instead of requiring a follow-up call per
  milestone.
- **Response `200`:** `PlannerMilestoneFull[]`, sorted by date ascending. When `deep` is not set,
  every milestone's `entries` field is simply absent from the JSON (empty-array-omitted).

### Create a milestone — `create_milestone`

`POST /api/v0/planner/milestones`

- **Auth:** `Permission::Basic`
- **Request body:** `NewPlannerMilestone`
- **Response `201`:** `PlannerMilestone`
- **Errors:** `422` (no body) on empty/oversized title.

### Get a milestone — `get_milestone`

`GET /api/v0/planner/milestones/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Response `200`:** `PlannerMilestoneFull` — **always** includes `entries` (unlike the list
  endpoint, there's no shallow variant for a single milestone; no `deep` param here).
- **Errors:** `404` (no body) if not found/owned.

> Note: there used to be a separate `GET /milestones/{id}/entries` endpoint; it has been removed.
> Use `GET /milestones/{id}` (always deep) to get a milestone's entries now.

### Update a milestone — `update_milestone`

`PATCH /api/v0/planner/milestones/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Request body:** `PlannerMilestoneChanges` — remember `description`'s tri-state semantics.
- **Response `200`:** `PlannerMilestone` (not `...Full` — no `entries` field here).
- **Errors:** `404` (no body) if not found/owned; `422` (no body) if a provided `title` is
  empty/oversized.

### Delete a milestone — `delete_milestone`

`DELETE /api/v0/planner/milestones/{id}`

- **Auth:** `Permission::Basic`
- **Path params:** `id` (uuid)
- **Response `204`:** no body.
- **Errors:** `404` (no body) if not found/owned.

### Planner assistant (free-text parsing) — `planner_assistant`

`POST /api/v0/planner/assistant`

- **Auth:** `Permission::Basic`
- **Request body:** `PlannerAssistantRequest`
- **Response `200`:** `NewPlannerEntry[]` — LLM-parsed entries, **not yet created**. The client is
  expected to review/edit and then `POST` them to `/entries` to actually persist them.
- **Errors:** `500` (no body) on any LLM/OpenAI failure (`PlannerError::LlmError` maps to a bare
  `500`, no error detail is exposed to the client).

---

## Client implementation notes

1. **Two entry shapes.** `GET /entries` and `GET /entries/{id}` return `PlannerEntryFull`
   (`milestone` object). `POST /entries` and `PATCH /entries/{id}` return plain `PlannerEntry`
   (`milestone_id` string). If you keep a single client-side `Entry` type, normalize immediately
   after create/update by either re-fetching or deriving `milestone` from a locally cached milestone
   list keyed by id.
2. **Two milestone shapes**, same story: `GET /milestones` and `GET /milestones/{id}` return
   `PlannerMilestoneFull` (with `entries`); `POST` and `PATCH` return plain `PlannerMilestone`
   (no `entries`).
3. **Tri-state PATCH fields** — treat "key absent" and "key present with `null`" as different
   requests:
   - `PlannerEntryChanges.milestone_id`
   - `PlannerMilestoneChanges.description`
   Most JSON libraries default to omitting `null` fields or including all fields — check yours
   explicitly supports "send this key as `null`" vs. "don't send this key at all" before wiring up
   the "clear milestone" / "clear description" UI actions.
4. **No error response bodies anywhere in this feature.** Every error is a bare HTTP status code
   (`404`, `422`, `500`) with an empty body — don't try to parse a JSON error payload; branch on
   status code only.
5. **`deep` query param is presence-based, not boolean-valued.** `?deep=false` still counts as "set"
   server-side (it's `Option<String>`, checked with `.is_some()`). Omit the param to get the
   shallow response.
6. **The iCal endpoint is the only unauthenticated one and the only non-JSON one** in this feature —
   don't attach a bearer token to it (unnecessary, and the token-in-path is the actual auth
   mechanism), and parse its body as raw iCalendar text, not JSON.
7. **Bulk create is all-or-nothing.** `POST /entries` validates every item in the array before
   creating any of them; a single invalid entry fails the entire batch with `422`.
