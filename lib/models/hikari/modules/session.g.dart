// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionSource _$SessionSourceFromJson(Map<String, dynamic> json) =>
    SessionSource(
      fileId: json['file_id'] as String,
      fileName: json['file_name'] as String,
    );

Map<String, dynamic> _$SessionSourceToJson(SessionSource instance) =>
    <String, dynamic>{
      'file_id': instance.fileId,
      'file_name': instance.fileName,
    };

LockedUntil _$LockedUntilFromJson(Map<String, dynamic> json) => LockedUntil(
  type: $enumDecode(_$LockTypeEnumMap, json['type']),
  time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
);

Map<String, dynamic> _$LockedUntilToJson(LockedUntil instance) =>
    <String, dynamic>{
      'type': _$LockTypeEnumMap[instance.type]!,
      'time': instance.time?.toIso8601String(),
    };

const _$LockTypeEnumMap = {
  LockType.undefined: 'undefined',
  LockType.timed: 'timed',
};

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  id: json['id'] as String,
  title: json['title'] as String,
  status: $enumDecode(_$SessionStatusEnumMap, json['status']),
  llm: json['llm'] as bool? ?? false,
  hidden: json['hidden'] as bool? ?? false,
  quizzable: json['quizzable'] as bool? ?? false,
  topics:
      (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  llmProvider: Session._llmProviderFromJson(json['llm-provider'] as String?),
  sources: (json['sources'] as List<dynamic>?)
      ?.map((e) => SessionSource.fromJson(e as Map<String, dynamic>))
      .toList(),
  completion: json['completion'] == null
      ? null
      : DateTime.parse(json['completion'] as String),
  lockedUntil: Session._lockedUntilFromJson(json['locked-until']),
  text: json['text'] as String?,
  bot: json['bot'] as String?,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  banner: json['banner'] as String?,
  nextSession: json['next-session'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'topics': instance.topics,
  'status': _$SessionStatusEnumMap[instance.status]!,
  'completion': instance.completion?.toIso8601String(),
  'bot': instance.bot,
  'text': instance.text,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'icon': instance.icon,
  'banner': instance.banner,
  'locked-until': Session._lockedUntilToJson(instance.lockedUntil),
  'sources': instance.sources,
  'next-session': instance.nextSession,
  'llm': instance.llm,
  'hidden': instance.hidden,
  'quizzable': instance.quizzable,
  'llm-provider': Session._llmProviderToJson(instance.llmProvider),
  'metadata': instance.metadata,
};

const _$SessionStatusEnumMap = {
  SessionStatus.notStarted: 'not_started',
  SessionStatus.started: 'started',
  SessionStatus.finished: 'finished',
};
