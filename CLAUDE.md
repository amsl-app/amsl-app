# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`amsl-app` is a Flutter-based self-regulated learning app for iOS and Android. It connects to a backend called **Hikari** (via REST + WebSocket) and uses **Riverpod** for state management throughout.

## Commands

```bash
# Initial setup (generates .env and config files)
make setup-local

# Run with a specific flavor (required — there is no default main)
flutter run --flavor dev lib/main_dev.dart
flutter run --flavor qa lib/main_qa.dart
flutter run --flavor staging lib/main_staging.dart
flutter run --flavor prod lib/main_prod.dart

# Analyze / lint
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Regenerate code (freezed, riverpod, json_serializable, theme_tailor)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for codegen
dart run build_runner watch --delete-conflicting-outputs
```

## Architecture

### Entry Points & Flavors

There are four flavors: `dev`, `qa`, `staging`, `prod`. Each has its own `main_<flavor>.dart` that sets `F.appFlavor` and calls `common_main()` in `lib/main_common.dart`. Flavor-specific values (API URLs, auth endpoints, Matomo/Sentry URLs) live in `lib/flavors.dart`, which is a **template file** populated by `scripts/setup_local_config.py` from `.env`.

### State Management: Riverpod + Hooks

All state is managed with `hooks_riverpod` + `riverpod_annotation`. Providers use the `@Riverpod` code-gen annotation. Generated files end in `.g.dart` — never edit them. Use `riverpod_annotation` scoped dependencies (`dependencies: [...]`) to avoid implicit global state.

The root `ProviderScope` in `main_common.dart` injects `storagesProvider` (SharedPreferences + SecureStorage) and `packageInfoProvider` as overrides.

### Routing

Navigation uses `go_router` (v17). The router is created in `lib/router.dart` and is login-state-aware: unauthenticated users land on `/start`, authenticated users on `/home`. The main shell is a `StatefulShellRoute.indexedStack` with three branches:
- **Home** (`/home`): main screen, chat, reflection/journal, quiz
- **Modules** (`/modules`): module list → session selection → assessment
- **Profile** (`/profile`): settings, notifications, debug

### API Layer: Hikari

`lib/hikari/` is the HTTP/WebSocket client layer. `HikariApiClient` wraps an `http` client with automatic token injection (via `AuthController`) and retry logic. It exposes domain APIs via `Hikari` (a facade): `assessmentApi`, `journalApi`, `moduleApi`, `userApi`, `utilApi`, `quizApi`.

`HikariPod` (in `lib/providers/hikari_provider.dart`) is the Riverpod provider for `Hikari`. It throws `AuthenticationException` when the user is unauthenticated, triggering automatic logout on 401s.

### Authentication

`AuthController` (`lib/authentication/auth.dart`) manages OAuth2 tokens via `flutter_appauth`. It handles token refresh with a `Completer`-based coalescing pattern to prevent concurrent refresh races. Login/logout state flows through `loginProvider` → `asyncLoginProvider` (Riverpod notifiers in `lib/authentication/`).

### Data Models

Models are split into two namespaces:
- `lib/models/hikari/` — raw API response models (JSON-serializable via `json_annotation`)
- `lib/models/tori/` — app-facing domain models
- Feature-local models live inside `lib/features/<feature>/models/`

Immutable models use `freezed`. All generated code (`.g.dart`, `.freezed.dart`) is checked in.

### Features

Each feature in `lib/features/<name>/` follows a consistent structure:
- `models/` — feature-specific data models
- `providers/` — Riverpod providers
- `repository/` — data fetching/business logic
- `widgets/` — UI, with `screens/` for full-page widgets

Key features:
- **chat** — real-time AI chat via WebSocket streams (`ChatControllerNotifier`, `ChatRepositoryNotifier`, `ChatChannelNotifier`)
- **modules** — learning module list and session selection
- **assessment** — pre/post assessments per module
- **quiz** — spaced-repetition quiz sessions
- **journal** — reflection journal with mood tracking
- **profile** — user settings, notifications, debug panel

### Themes

Custom theme extensions use `theme_tailor` (`.tailor.dart` generated files). App-wide theme is in `lib/themes/app_theme.dart`.

**Always use theme colors — never hardcode colors.** Access colors via `Theme.of(context).colorScheme` or custom theme extensions. Never use `Color(0x...)`, `Colors.red`, etc. directly in widgets.

### Constants

Shared constants live in `lib/constants.dart`. Use them instead of redefining locally:
- `ApiConstants` — base URL, API path, scheme helpers, redirect URL
- `getBottomBarHeight(context)` / `getBottomBarPadding(context)` — platform-aware bottom bar sizing
- `kNewDateFormat` / `kOldDateFormat` / `kNewDateTimeFormat` / `kOldTimeFormat` — standard `DateFormat` instances

### Code Generation

These generators are in use — run `build_runner` after modifying annotated files:
- `freezed` → immutable models + unions
- `json_serializable` → JSON serialization
- `riverpod_generator` → provider boilerplate
- `theme_tailor` → theme extension classes

### Git Clean Filters

Sensitive files (`lib/flavors.dart`, Firebase config files, `project.pbxproj`) are scrubbed by Python git clean filters configured via `make setup-git`. Run `make verify-git-filters` to confirm they're working before committing changes to these files.
