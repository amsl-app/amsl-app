import 'package:json_annotation/json_annotation.dart';

part 'module_group.g.dart';

@JsonSerializable()
class ModuleGroup {
  final String key;
  final String label;
  @JsonKey(name: 'modules')
  final List<String> moduleIDs;
  final int weight;

  const ModuleGroup({
    required this.key,
    required this.label,
    required this.moduleIDs,
    this.weight = 0,
  });

  factory ModuleGroup.fromJson(Map<String, dynamic> json) =>
      _$ModuleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleGroupToJson(this);
}
