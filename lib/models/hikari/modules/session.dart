import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moment_dart/moment_dart.dart';
import '../../botflow.dart';

part 'session.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SessionStatus { notStarted, started, finished }

// TOOD check if this is still needed
@JsonEnum(fieldRename: FieldRename.snake)
enum JournalingType { chat, text, any }

@JsonEnum(fieldRename: FieldRename.snake)
enum KnownLlmProvider { openai, gwdg, win }

class LlmProvider {
  final String value;

  const LlmProvider._(this.value);

  // Predefined providers
  static const LlmProvider openai = LlmProvider._('openai');
  static const LlmProvider gwdg = LlmProvider._('gwdg');
  static const LlmProvider win = LlmProvider._('win');

  // Constructor for custom providers
  const LlmProvider.custom(this.value);

  // Factory constructor that returns known providers or creates custom ones
  factory LlmProvider.fromString(String value) {
    switch (value) {
      case 'openai':
        return LlmProvider.openai;
      case 'gwdg':
        return LlmProvider.gwdg;
      case 'win':
        return LlmProvider.win;
      default:
        return LlmProvider.custom(value);
    }
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LlmProvider &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@JsonSerializable()
class SessionSource {
  @JsonKey(name: "file_id")
  final String fileId;
  @JsonKey(name: "file_name")
  final String fileName;

  SessionSource({required this.fileId, required this.fileName});

  factory SessionSource.fromJson(Map<String, dynamic> json) =>
      _$SessionSourceFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSourceToJson(this);
}

enum LockType { undefined, timed }

@JsonSerializable()
class LockedUntil {
  final LockType type;
  final DateTime? time;

  const LockedUntil({required this.type, this.time});

  factory LockedUntil.undefined() =>
      const LockedUntil(type: LockType.undefined);

  factory LockedUntil.timed(DateTime time) =>
      LockedUntil(type: LockType.timed, time: time);

  String unlockHint() {
    if (type == LockType.undefined) return "Wird bald freigeschaltet.";
    if (type == LockType.timed && time != null) {
      return "Ab ${time!.toLocal().toMoment().calendar(omitHours: false)}";
    }
    return time!.difference(DateTime.now()).toDurationString(round: false);
  }

  factory LockedUntil.fromJson(Map<String, dynamic> json) {
    return _$LockedUntilFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LockedUntilToJson(this);
}

@JsonSerializable()
class Session {
  const Session({
    required this.id,
    required this.title,
    required this.status,
    required this.llm,
    required this.hidden,
    required this.quizzable,
    this.topics = const [],
    this.llmProvider,
    this.sources,
    this.completion,
    this.lockedUntil,
    this.text,
    this.bot,
    this.subtitle,
    this.description,
    this.icon,
    this.banner,
    this.nextSession,
    this.metadata,
  });

  final String id;
  final String title;
  final List<String> topics;
  final SessionStatus status;
  final DateTime? completion;
  final String? bot;
  final String? text;
  final String? subtitle;
  final String? description;
  final String? icon;
  final String? banner;
  @JsonKey(
    name: "locked-until",
    fromJson: _lockedUntilFromJson,
    toJson: _lockedUntilToJson,
  )
  final LockedUntil? lockedUntil;
  final List<SessionSource>? sources;
  @JsonKey(name: "next-session")
  final String? nextSession;
  @JsonKey(defaultValue: false)
  final bool llm;
  @JsonKey(defaultValue: false)
  final bool hidden;
  @JsonKey(defaultValue: false)
  final bool quizzable;
  @JsonKey(
    name: "llm-provider",
    fromJson: _llmProviderFromJson,
    toJson: _llmProviderToJson,
  )
  final LlmProvider? llmProvider;
  final Map<String, dynamic>? metadata;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  BotFlow? get botflow {
    if (bot == null) return null;
    final parts = bot!.split("/");
    if (parts.length == 2) {
      return BotFlow(bot: parts[0], flow: parts[1]);
    } else if (parts.length == 1) {
      return BotFlow(bot: parts[0]);
    }
    throw Exception("Invalid flow path: $bot");
  }

  static LlmProvider? _llmProviderFromJson(String? json) =>
      json != null ? LlmProvider.fromString(json) : null;

  static String? _llmProviderToJson(LlmProvider? provider) => provider?.value;

  static LockedUntil? _lockedUntilFromJson(dynamic value) {
    if (value is String && value == 'undefined') {
      return LockedUntil.undefined();
    } else if (value is Map<String, dynamic> && value.containsKey('time')) {
      final timeString = value['time'] as String;
      final dateTime = DateTime.parse(timeString);
      return LockedUntil.timed(dateTime);
    } else if (value == null) {
      return null;
    }
    throw ArgumentError('Invalid locked_until format: $value');
  }

  static dynamic _lockedUntilToJson(LockedUntil? lockedUntil) {
    if (lockedUntil == null || lockedUntil.type == LockType.undefined) {
      return 'undefined';
    } else if (lockedUntil.type == LockType.timed && lockedUntil.time != null) {
      return {'time': lockedUntil.time!.toIso8601String()};
    }
    throw ArgumentError('Invalid LockedUntil object: $lockedUntil');
  }
}
