import 'package:amsl_app/models/botflow.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../../hikari/modules/session.dart';
import 'module.dart';

class Session {
  static Logger log = Logger('Session');

  Session({
    required Module module,
    required this.index,
    required this.id,
    required this.title,
    required this.status,
    required this.isLlm,
    required this.llmProvider,
    required this.sources,
    required this.hide,
    required this.quizzable,
    required this.topics,
    this.completion,
    this.lockedUntil,
    this.botflow,
    this.text,
    this.subtitle,
    this.description,
    this.icon,
    this.banner,
    this.metadata,
  }) {
    this.module = WeakReference(module);
    if (metadata == null) {
      journalingType = null;
      return;
    }
    Map<String, dynamic>? annotations = metadata!['annotations']
        ?.cast<String, dynamic>();

    if (annotations == null) {
      journalingType = null;
      return;
    }

    String? mode = annotations['journaling/tutorial-mode'];
    journalingType = mode == 'chat'
        ? JournalingType.chat
        : mode == 'text'
        ? JournalingType.text
        : JournalingType.any;

    for (int i = 0; i < annotations.length; i++) {
      String? prompt = annotations['journaling/prompt/$i'];
      if (prompt != null) {
        prompts.add(prompt);
      }
    }

    log.fine(
      "Session with annotations: $id, Prompts: $prompts, Mode: ${journalingType.toString()}}",
    );
  }

  late final WeakReference<Module> module;
  late final JournalingType? journalingType;
  final List<String> prompts = [];
  final int index;
  final String id;
  final String title;
  final SessionStatus status;
  final List<String> topics;
  final bool hide;
  final bool quizzable;
  final DateTime? completion;
  final List<SessionSource> sources;
  final LockedUntil? lockedUntil;
  final String? subtitle;
  final String? description;
  final String? icon;
  final String? banner;
  final BotFlow? botflow;
  final String? text;
  final bool isLlm;
  final LlmProvider? llmProvider;
  final Map<String, dynamic>? metadata;
  late final Session? next;

  Session copyWith({
    Module? module,
    int? index,
    String? id,
    String? title,
    List<String>? topics,
    BotFlow? botflow,
    String? text,
    SessionStatus? status,
    LockedUntil? lockedUntil,
    String? subtitle,
    String? description,
    String? icon,
    String? banner,
    Session? next,
    DateTime? completion,
    List<SessionSource>? sources,
    bool? isLlm,
    bool? hide,
    bool? quizzable,
    LlmProvider? llmProvider,
    Map<String, dynamic>? metadata,
  }) {
    Session session = Session(
      topics: topics ?? this.topics,
      module: module ?? this.module.target!,
      index: index ?? this.index,
      id: id ?? this.id,
      title: title ?? this.title,
      botflow: botflow ?? this.botflow,
      text: text ?? this.text,
      status: status ?? this.status,
      lockedUntil: lockedUntil ?? this.lockedUntil,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      sources: (sources ?? this.sources).sorted(
        (a, b) => a.fileName.compareTo(b.fileName),
      ),
      icon: icon ?? this.icon,
      banner: banner ?? this.banner,
      completion: completion ?? this.completion,
      metadata: metadata ?? this.metadata,
      isLlm: isLlm ?? this.isLlm,
      llmProvider: llmProvider ?? this.llmProvider,
      hide: hide ?? this.hide,
      quizzable: quizzable ?? this.quizzable,
    );

    session.next = next ?? this.next;
    return session;
  }

  bool get unlocked {
    if (lockedUntil == null) return true;
    return false;
  }

  @override
  String toString() {
    return 'Session{module: $module, index: $index, id: $id, title: $title, status: $status, completion: $completion, lockedUntil: $lockedUntil, subtitle: $subtitle, description: $description, icon: $icon, banner: $banner, botflow: $botflow, text: $text, journalingType: $journalingType, next: ${next?.id}, metadata: $metadata, isLLm: $isLlm}';
  }
}
