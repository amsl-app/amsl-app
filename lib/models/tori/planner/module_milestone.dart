import 'package:amsl_app/models/hikari/planner/module_milestone.dart'
    as hikari_planner;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_milestone.freezed.dart';

@freezed
abstract class ModuleMilestone with _$ModuleMilestone {
  const ModuleMilestone._();

  const factory ModuleMilestone({
    required String id,
    required String title,
    required DateTime date,
    required bool alreadyImported,
    String? description,
  }) = _ModuleMilestone;

  factory ModuleMilestone.fromHikari(hikari_planner.ModuleMilestone m) =>
      ModuleMilestone(
        id: m.id,
        title: m.title,
        date: m.date,
        description: m.description,
        alreadyImported: m.alreadyImported,
      );
}
