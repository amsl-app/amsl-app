// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
  title: json['title'] as String,
  id: json['id'] as String,
  category: $enumDecode(
    _$ModuleCategoryEnumMap,
    json['category'],
    unknownValue: ModuleCategory.unknown,
  ),
  sessions: (json['sessions'] as List<dynamic>)
      .map((e) => Session.fromJson(e as Map<String, dynamic>))
      .toList(),
  assessments: (json['assessment'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  hidden: json['hidden'] as bool? ?? false,
  selfLearning: json['self-learning'] as bool? ?? false,
  quizzable: json['quizzable'] as bool? ?? false,
  weight: (json['weight'] as num?)?.toInt() ?? 1,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  banner: json['banner'] as String?,
  theme: json['theme'] == null
      ? null
      : Theme.fromJson(json['theme'] as Map<String, dynamic>),
  defaultSession: json['default-session'] as String?,
  completion: json['completion'] == null
      ? null
      : DateTime.parse(json['completion'] as String),
  groups: (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
  'title': instance.title,
  'id': instance.id,
  'metadata': instance.metadata,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'icon': instance.icon,
  'banner': instance.banner,
  'theme': instance.theme,
  'hidden': instance.hidden,
  'self-learning': instance.selfLearning,
  'quizzable': instance.quizzable,
  'weight': instance.weight,
  'category': _$ModuleCategoryEnumMap[instance.category]!,
  'assessment': instance.assessments,
  'default-session': instance.defaultSession,
  'sessions': instance.sessions,
  'completion': instance.completion?.toIso8601String(),
  'groups': instance.groups,
};

const _$ModuleCategoryEnumMap = {
  ModuleCategory.onboarding: 'onboarding',
  ModuleCategory.learning: 'learning',
  ModuleCategory.course: 'course',
  ModuleCategory.journal: 'journal',
  ModuleCategory.unknown: 'unknown',
};
