import 'dart:convert';

import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/models/hikari/planner/new_planner_entry.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
import 'package:logging/logging.dart';

class HikariPlannerApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariPlannerApi');

  const HikariPlannerApi(this.hikari);

  Future<List<PlannerEntry>> getEntries({String? from, String? to}) =>
      hikari.get(
        '/planner/entries',
        queryParameters: {
          'from': ?from,
          'to': ?to,
        },
        transform: (json) => [
          for (final e in json as List) PlannerEntry.fromJson(e),
        ],
      );

  Future<PlannerEntry> createEntry({
    required String date,
    required String title,
    required int priority,
    String? moduleId,
    String? sessionId,
  }) =>
      hikari.post(
        '/planner/entries',
        body: jsonEncode({
          'date': date,
          'title': title,
          'priority': priority,
          'module_id': ?moduleId,
          'session_id': ?sessionId,
        }),
        transform: (json) => PlannerEntry.fromJson(json),
      );

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
  }) =>
      hikari.patch(
        '/planner/entries/$id',
        body: jsonEncode({
          'completed': ?completed,
          'date': ?date,
          'title': ?title,
          'priority': ?priority,
          // ignore: use_null_aware_elements
          if (moduleId != null || clearModule) 'module_id': moduleId,
          // ignore: use_null_aware_elements
          if (sessionId != null || clearSession) 'session_id': sessionId,
        }),
        transform: (json) => PlannerEntry.fromJson(json),
      );

  Future<void> deleteEntry(String id) =>
      hikari.delete('/planner/entries/$id');

  Future<List<PlannerEntry>> bulkCreateEntries(
    List<NewPlannerEntry> entries,
  ) =>
      hikari.post(
        '/planner/entries/bulk',
        body: jsonEncode([for (final e in entries) e.toJson()]),
        transform: (json) => [
          for (final e in json as List) PlannerEntry.fromJson(e),
        ],
      );

  Future<List<NewPlannerEntry>> askAssistant({
    required String text,
    String? today,
  }) =>
      hikari.post(
        '/planner/assistant',
        body: jsonEncode({'text': text, 'today': ?today}),
        transform: (json) => [
          for (final e in json as List) NewPlannerEntry.fromJson(e),
        ],
      );

  Future<String> getIcalToken() => hikari.get(
    '/planner/ical-token',
    transform: (json) => json['token'] as String,
  );

  Future<void> deleteIcalToken() => hikari.delete('/planner/ical-token');
}
