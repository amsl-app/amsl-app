import 'dart:convert';

import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/features/planner/models/new_planner_entry.dart';
import 'package:amsl_app/features/planner/models/new_planner_milestone.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
import 'package:amsl_app/models/hikari/planner/planner_milestone.dart';
import 'package:logging/logging.dart';

class HikariPlannerApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariPlannerApi');

  const HikariPlannerApi(this.hikari);

  Future<List<PlannerEntry>> getEntries({String? from, String? to}) =>
      hikari.get(
        '/planner/entries',
        queryParameters: {'from': ?from, 'to': ?to},
        transform: (json) => [
          for (final e in json as List) PlannerEntry.fromJson(e),
        ],
      );

  Future<List<PlannerEntry>> createEntries(List<NewPlannerEntry> entries) =>
      hikari.post(
        '/planner/entries',
        body: jsonEncode([for (final e in entries) e.toJson()]),
        transform: (json) => [
          for (final e in json as List) PlannerEntry.fromJson(e),
        ],
      );

  Future<PlannerEntry> updateEntry(
    String id, {
    bool? completed,
    String? date,
    String? title,
    int? priority,
    String? milestoneId,
    bool clearMilestone = false,
  }) => hikari.patch(
    '/planner/entries/$id',
    body: jsonEncode({
      'completed': ?completed,
      'date': ?date,
      'title': ?title,
      'priority': ?priority,
      // ignore: use_null_aware_elements
      if (milestoneId != null || clearMilestone) 'milestone_id': milestoneId,
    }),
    transform: (json) => PlannerEntry.fromJson(json),
  );

  Future<void> deleteEntry(String id) => hikari.delete('/planner/entries/$id');

  Future<List<NewPlannerEntry>> askAssistant({
    required String text,
    String? today,
  }) => hikari.post(
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

  Future<List<PlannerMilestone>> getMilestones() => hikari.get(
    '/planner/milestones',
    transform: (json) => [
      for (final m in json as List) PlannerMilestone.fromJson(m),
    ],
  );

  Future<PlannerMilestone> createMilestone(NewPlannerMilestone milestone) =>
      hikari.post(
        '/planner/milestones',
        body: jsonEncode(milestone.toJson()),
        transform: (json) => PlannerMilestone.fromJson(json),
      );

  Future<PlannerMilestone> updateMilestone(
    String id, {
    String? title,
    String? date,
    String? description,
    bool clearDescription = false,
  }) => hikari.patch(
    '/planner/milestones/$id',
    body: jsonEncode({
      'title': ?title,
      'date': ?date,
      // ignore: use_null_aware_elements
      if (description != null || clearDescription) 'description': description,
    }),
    transform: (json) => PlannerMilestone.fromJson(json),
  );

  Future<void> deleteMilestone(String id) =>
      hikari.delete('/planner/milestones/$id');
}
