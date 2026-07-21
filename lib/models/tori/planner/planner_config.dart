import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_config.freezed.dart';

@freezed
abstract class PlannerConfig with _$PlannerConfig {
  const PlannerConfig._();

  const factory PlannerConfig({
    required List<PlannerEntry> entries,
    required Map<String, PlannerMilestone> milestones,
  }) = _PlannerConfig;

  List<PlannerMilestone> get sortedMilestones =>
      milestones.values.sortedBy((m) => m.date);

  List<PlannerEntry> get unassignedEntries =>
      entries.where((e) => e.milestone == null).toList();

  List<PlannerEntry> entriesForMilestone(String milestoneId) =>
      entries.where((e) => e.milestone?.id == milestoneId).toList();

  Iterable<(PlannerMilestone, List<PlannerEntry>)> get milestonesWithEntries =>
      sortedMilestones.map((m) => (m, entriesForMilestone(m.id)));
}
