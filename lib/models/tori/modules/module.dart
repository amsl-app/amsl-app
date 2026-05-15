import 'package:amsl_app/models/hikari/modules/module.dart' as hikari_module;
import 'package:amsl_app/models/hikari/modules/session.dart' as hikari_session;
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logging/logging.dart';

import '../../hikari/modules/module_category.dart';
import 'module_themes.dart';

class Module {
  static final log = Logger("Tori-Module");

  Module({
    required this.title,
    required this.id,
    required this.hide,
    required this.selfLearning,
    required this.quizzable,
    required this.weight,
    required this.defaultSession,
    required this.sessions,
    required this.assessments,
    required this.category,
    required this.theme,
    required this.groups,
    this.subtitle,
    this.description,
    this.icon,
    this.banner,
    this.metadata,
    this.completion,
  });

  final String title;
  final String id;
  final int weight;
  final String? subtitle;
  final String? description;
  final String? icon;
  final String? banner;
  final ModuleTheme? theme;
  late final Session? defaultSession;
  final bool hide;
  final bool selfLearning;
  final bool quizzable;
  late final ListMap<String, Session> sessions;
  late final List<String> groups;
  final Map<String, String>? assessments;
  final ModuleCategory category;
  final Map<String, dynamic>? metadata;
  final DateTime? completion;

  @override
  String toString() {
    return "Module(id: $id, weight: $weight, hide: $hide, assessments: $assessments, metadata $metadata)";
  }

  Module.fromHikari(hikari_module.Module module)
    : title = module.title,
      id = module.id,
      subtitle = module.subtitle,
      description = module.description,
      icon = module.icon,
      banner = module.banner,
      hide = module.hidden,
      selfLearning = module.selfLearning,
      quizzable = module.quizzable,
      weight = module.weight,
      category = module.category,
      assessments = module.assessments,
      metadata = module.metadata,
      completion = module.completion,
      theme = ModuleThemes.get(module.theme?.id),
      groups = module.groups ?? [] {
    sessions = ListMap.fromEntries(
      module.sessions.mapIndexed(
        (index, s) => MapEntry(
          s.id,
          Session(
            module: this,
            index: index,
            id: s.id,
            title: s.title,
            status: s.status,
            topics: s.topics,
            lockedUntil: s.lockedUntil,
            botflow: s.botflow,
            text: s.text,
            subtitle: s.subtitle,
            sources: (s.sources ?? []).sorted(
              (a, b) => a.fileName.compareTo(b.fileName),
            ),
            description: s.description,
            icon: s.icon,
            banner: s.banner,
            completion: s.completion,
            metadata: s.metadata,
            isLlm: s.llm,
            llmProvider: s.llmProvider,
            hide: s.hidden,
            quizzable: s.quizzable,
          ),
        ),
      ),
    );
    for (final session in module.sessions) {
      final a = sessions.getOrThrow(session.id);
      log.fine("Setting next of ${session.id}");
      if (session.nextSession == null) {
        // We marked this as next file so we have to initialize it
        a.next = null;
        continue;
      }
      final b = sessions.get(session.nextSession!);

      if (b == null) {
        log.warning(
          "Next session specified but session with the given name does note exist",
        );
        // We marked this as next file so we have to initialize it
        a.next = null;
      } else {
        a.next = b;
      }
    }

    switch (module.defaultSession) {
      case var sessionId?:
        final session = sessions.get(sessionId);
        if (session == null) {
          log.warning(
            "Default session specified but the session does not exist",
          );
        }
        defaultSession = session;
        break;
      default:
        defaultSession = null;
    }
  }

  int get sessionsToDo {
    if (completion != null) return 0;

    int counter = 0;

    for (Session session in sessions.values) {
      if (session.completion == null && !session.hide) counter++;
    }

    return counter;
  }

  // sessions that are completed based on the completion field
  int get doneCount {
    int counter = 0;

    for (Session session in sessions.values) {
      if (session.completion != null && !session.hide) counter++;
    }
    return counter;
  }

  // if any session is started
  bool get started {
    if (completion != null) return true; // have to be started to be completed

    for (Session session in sessions.values) {
      if (session.status != hikari_session.SessionStatus.notStarted ||
          session.completion != null) {
        return true;
      }
    }
    return false;
  }
}

class ModuleVariant {
  final String baseId;
  final ModuleVariantType type;
  final String value;

  ModuleVariant({
    required this.baseId,
    this.type = ModuleVariantType.group,
    required this.value,
  });
}

enum ModuleVariantType { group }
