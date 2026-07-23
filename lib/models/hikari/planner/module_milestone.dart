import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_milestone.freezed.dart';
part 'module_milestone.g.dart';

@freezed
abstract class ModuleMilestone with _$ModuleMilestone {
  factory ModuleMilestone({
    required String id,
    required String title,
    required DateTime date,
    @JsonKey(name: 'already_imported') required bool alreadyImported,
    String? description,
  }) = _ModuleMilestone;

  factory ModuleMilestone.fromJson(Map<String, dynamic> json) =>
      _$ModuleMilestoneFromJson(json);
}
