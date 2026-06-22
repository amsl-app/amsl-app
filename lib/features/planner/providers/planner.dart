import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/hikari/planner/new_planner_entry.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'planner.g.dart';

/// Groups entries by their day (time component stripped), preserving order.
Map<DateTime, List<PlannerEntry>> groupEntriesByDay(List<PlannerEntry> entries) {
  final map = <DateTime, List<PlannerEntry>>{};
  for (final entry in entries) {
    final day = DateTime(entry.date.year, entry.date.month, entry.date.day);
    map.putIfAbsent(day, () => []).add(entry);
  }
  return map;
}

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class PlannerProvider extends _$PlannerProvider {
  @override
  Future<List<PlannerEntry>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    try {
      final entries = await hikari.plannerApi.getEntries();
      return _sortedByDate(entries);
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () {
        ref.invalidateSelf();
        return future;
      });
    }
  }

  Future<PlannerEntry> createEntry({
    required String date,
    required String title,
    required int priority,
    String? moduleId,
    String? sessionId,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final entry = await hikari.plannerApi.createEntry(
        date: date,
        title: title,
        priority: priority,
        moduleId: moduleId,
        sessionId: sessionId,
      );
      state = AsyncData(_sortedByDate([...?state.value, entry]));
      return entry;
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => createEntry(
          date: date,
          title: title,
          priority: priority,
          moduleId: moduleId,
          sessionId: sessionId,
        ),
      );
    }
  }

  Future<PlannerEntry> updateEntry(
    String id, {
    bool? completed,
    String? date,
    String? title,
    int? priority,
    String? moduleId,
    String? sessionId,
    bool clearModule = false,
    bool clearSession = false,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final updated = await hikari.plannerApi.updateEntry(
        id,
        completed: completed,
        date: date,
        title: title,
        priority: priority,
        moduleId: moduleId,
        sessionId: sessionId,
        clearModule: clearModule,
        clearSession: clearSession,
      );
      state = AsyncData(
        _sortedByDate([
          for (final e in state.value ?? []) e.id == id ? updated : e,
        ]),
      );
      return updated;
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => updateEntry(
          id,
          completed: completed,
          date: date,
          title: title,
          priority: priority,
          moduleId: moduleId,
          sessionId: sessionId,
          clearModule: clearModule,
          clearSession: clearSession,
        ),
      );
    }
  }

  Future<void> deleteEntry(String id) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.plannerApi.deleteEntry(id);
      state = AsyncData(
        (state.value ?? []).where((e) => e.id != id).toList(),
      );
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => deleteEntry(id));
    }
  }

  Future<List<PlannerEntry>> bulkCreateEntries(
    List<NewPlannerEntry> entries,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final created = await hikari.plannerApi.bulkCreateEntries(entries);
      state = AsyncData(_sortedByDate([...?state.value, ...created]));
      return created;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => bulkCreateEntries(entries));
    }
  }

  List<PlannerEntry> _sortedByDate(List<PlannerEntry> entries) =>
      entries..sort((a, b) => a.date.compareTo(b.date));
}

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class IcalTokenProvider extends _$IcalTokenProvider {
  @override
  Future<String?> build() async {
    final hikari = ref.watch(hikariPodProvider);
    try {
      return await hikari.plannerApi.getIcalToken();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () {
        ref.invalidateSelf();
        return future;
      });
    }
  }

  Future<void> revoke() async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.plannerApi.deleteIcalToken();
      state = const AsyncData(null);
    } on HikariException catch (e) {
      throw e.copyWith(resolve: revoke);
    }
  }

  Future<void> regenerate() async {
    state = const AsyncLoading();
    final hikari = ref.read(hikariPodProvider);
    try {
      final token = await hikari.plannerApi.getIcalToken();
      state = AsyncData(token);
    } on HikariException catch (e) {
      throw e.copyWith(resolve: regenerate);
    }
  }
}
