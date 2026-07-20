---
name: adding-a-feature
description: Use when adding a new feature to this Flutter/Riverpod app — creating a lib/features/<name>/ folder, wiring a Hikari-backed provider, a screen, and registering it in the router or tools list. Covers the provider design conventions (@Riverpod codegen, scoped dependencies, HikariException retry, optimistic state).
---

# Adding a Feature

## Overview

Features live in `lib/features/<name>/` and follow a consistent folder + provider
pattern. State is Riverpod (code-generated), data comes from the **Hikari** backend
via a per-domain API class, and every network call funnels errors through
`HikariException.copyWith(resolve:)` so the UI's error bar can retry.

Use `lib/features/quiz/` as the reference implementation — it exercises the full
pattern (CRUD provider, screen, sheets + tools wiring).

## Feature folder structure

```
lib/features/<name>/
  providers/        # Riverpod providers (state)        — almost always present
  widgets/          # UI                                — almost always present
    screens/        # full-page widgets
```

## Models and APIs

The models are defined in `lib/models/hikari/<name>/` for serverside models and in `lib/models/tori/<name>/` for models we further process on the client (e.g. `QuizQuestion` is a Tori model derived from the Hikari `Question` model). The API class is in `lib/hikari/apis/hikari_<name>_api.dart` and is registered on the `Hikari` facade (`lib/hikari/hikari.dart`).

## Tool Wiring

If the user defined, that the new feature is a tool, you need to additionally wire it up in the tools list. This is done by adding a `Tool` entry in `lib/features/tools_common/providers/tools.dart` and a `GoRoute` in `lib/router.dart`.

## Steps to add a feature

1. Check if you have all the APIs and Models you need, if not create them in `lib/hikari/apis/hikari_<name>_api.dart` and `lib/models/hikari/<name>/` (freezed + json).
2. Create `lib/features/<name>/providers/` and `widgets/screens/`.
3. Write the provider(s) following the conventions below.
4. Build the screen as a `HookConsumerWidget`; read state with `ref.watch(...)`.
5. Register the screen: If it is a tool, register it in `lib/features/tools_common/providers/tools.dart` and `lib/router.dart`.
6. If the provider is an independent root source (depends only on `HikariPod`), add its
   `reloadX()` to `reloadAll` in `lib/widgets/error/error_bar.dart`.
7. `dart run build_runner build --delete-conflicting-outputs`, then `flutter analyze`.

## Provider conventions

**Always class-based codegen.** Never hand-write a `Provider`/`StateNotifier`.

Modelled on `lib/features/quiz/providers/quiz.dart`:

```dart
part 'quiz.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class QuizProvider extends _$QuizProvider {
  @override
  Future<List<Quiz>> build() async {
    final hikari = ref.watch(hikariPodProvider);   // watch in build()
    return _loadQuizzesFromApi(hikari);            // delegate to a private loader
  }

  // The loader owns the try/catch AND the Hikari→Tori conversion.
  Future<List<Quiz>> _loadQuizzesFromApi(Hikari hikari) async {
    try {
      final quizzes = await hikari.quizApi.getQuizzes();
      return quizzes.map((e) => Quiz.fromHikari(e)).toList(); // return Tori models
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadQuizzes);    // retry = re-run build()
    }
  }

  Future<List<Quiz>> reloadQuizzes() async {
    ref.invalidateSelf();
    return future;
  }

  Future<Quiz> startQuiz(String moduleId, List<String> sessionIds) async {
    final hikari = ref.read(hikariPodProvider);    // read in mutations
    try {
      final quiz =
          Quiz.fromHikari(await hikari.quizApi.startQuiz(moduleId, sessionIds));
      reloadQuizzes(); // this mutation affects other quizzes → reload all
      return quiz;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => startQuiz(moduleId, sessionIds));
    }
  }

  // In-place edit of the list state via update() (operates on the unwrapped value).
  void _upsertQuestionInQuiz(String quizId, Question updated) {
    update((quizzes) async => [
          for (final quiz in quizzes)
            quiz.id == quizId
                ? quiz.copyWith(questions: /* add/replace `updated` */)
                : quiz,
        ]);
  }
}
```

The generated provider is `quizProviderProvider`; call methods via
`ref.read(quizProviderProvider.notifier).startQuiz(...)`.

### Rules

- **`@Riverpod(keepAlive: true, dependencies: [...])`** — declare every provider you
  `ref.watch`/`read` by its class name (`HikariPod`, `ModuleNotifier`) or function
  name (`storages`). This scopes the provider; missing deps break override-based
  tests. Use `keepAlive: true` for feature state that should survive losing all
  listeners.
- **`build()` stays thin:** read `hikari` with `ref.watch(hikariPodProvider)` and hand
  it to a private `_loadXFromApi(Hikari hikari)` loader. The **loader** owns the
  `try/catch`.
- **Return Tori models, not raw Hikari DTOs.** Convert with `Tori.fromHikari(dto)`
  inside the loader/mutation. Hikari models (`lib/models/hikari/`) are server shapes;
  provider state is always the app-facing Tori model (`lib/models/tori/`).
- **Every Hikari call** is wrapped in `try { … } on HikariException catch (e) { throw
  e.copyWith(resolve: <retry>); }`. `resolve` is the closure the error bar runs on
  retry: in the loader use the `reloadX` method reference; in a mutation, re-call the
  same method with the same args.
- **Mutations** use `ref.read` (not `watch`). To update state: call `reloadX()` (which
  does `ref.invalidateSelf(); return future;`) when the change has server-side side
  effects; use `update((state) async => …)` for a purely local, in-place edit of the
  current list.
- **Naming:** class ends in `Provider` (`QuizProvider`, `QuizScoreProvider`). The
  generated symbol doubles the suffix — `QuizProvider` → `quizProviderProvider`.
- **Global refresh:** if the provider is an independent root source — it depends only
  on `HikariPod`, not on other feature providers like `UserPod`/`ModuleNotifier` — add
  a call to its `reloadX()` in `reloadAll` in `lib/widgets/error/error_bar.dart` so a
  full app refresh re-fetches it. Providers that depend on another provider reload
  transitively when that dependency reloads, so they must NOT be added.

## Quick reference

| Need | Do |
|------|-----|
| New provider | `@Riverpod(keepAlive: true, dependencies:[HikariPod]) class XProvider extends _$XProvider` + `part 'x.g.dart'` |
| Load in build | `build()` → `ref.watch(hikariPodProvider)` → private `_loadXFromApi(hikari)` |
| Call backend | `hikari.<domain>Api.<method>()` inside the loader/mutation |
| DTO → state | `Tori.fromHikari(dto)` — never store raw Hikari models |
| Handle error | `on HikariException catch (e) { throw e.copyWith(resolve: <retry>); }` |
| Refresh self | `Future<T> reloadX() { ref.invalidateSelf(); return future; }` |
| Edit list state | `update((state) async => …)` |
| Call from UI | `ref.read(xProviderProvider.notifier).method()` |
| Render state | `ref.watch(xProviderProvider)` in a `HookConsumerWidget` |
| Regenerate | `dart run build_runner build --delete-conflicting-outputs` |

## Common mistakes

- Forgetting a `dependencies:` entry → provider resolves globally and breaks scoped
  overrides. List every watched/read provider.
- Using `ref.watch` inside a mutation method — use `ref.read`.
- Storing raw Hikari DTOs in provider state — convert to Tori models with
  `.fromHikari()` first.
- Catching a bare `Exception` or swallowing errors instead of rethrowing via
  `copyWith(resolve:)` — the error bar then can't offer retry.
- Editing a `.g.dart`/`.freezed.dart` file — rerun build_runner instead.
- Hardcoding colors in the widget — use `Theme.of(context).colorScheme` (see
  `CLAUDE.md`).
