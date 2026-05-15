import 'package:amsl_app/models/hikari/modules/theme.dart';
import 'package:json_annotation/json_annotation.dart';

import 'module_category.dart';
import 'session.dart';

part 'module.g.dart';

@JsonSerializable()
class Module {
  const Module({
    required this.title,
    required this.id,
    required this.category,
    required this.sessions,
    required this.assessments,
    this.metadata,
    this.hidden = false,
    this.selfLearning = false,
    this.quizzable = false,
    this.weight = 1,
    this.subtitle,
    this.description,
    this.icon,
    this.banner,
    this.theme,
    this.defaultSession,
    this.completion,
    this.groups,
  });

  final String title;
  final String id;
  final Map<String, dynamic>? metadata;
  final String? subtitle;
  final String? description;
  final String? icon;
  final String? banner;
  final Theme? theme;
  final bool hidden;
  @JsonKey(name: "self-learning")
  final bool selfLearning;
  final bool quizzable;
  final int weight;
  @JsonKey(unknownEnumValue: ModuleCategory.unknown)
  final ModuleCategory category;
  @JsonKey(name: "assessment")
  final Map<String, String>? assessments;
  @JsonKey(name: "default-session")
  final String? defaultSession;
  final List<Session> sessions;
  final DateTime? completion;
  final List<String>? groups;

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
