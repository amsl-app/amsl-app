import 'package:amsl_app/features/history/providers/history_provider.dart';
import 'package:amsl_app/features/history/widgets/screens/filtered_history.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../../models/hikari/modules/module_category.dart';
import '../../../../models/tori/history/history_entry.dart';
import '../history_tile.dart';

class History extends HookConsumerWidget {
  static final log = Logger("History");

  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyRef = ref.watch(historyProviderProvider);
    return historyRef.build(
      context,
      builder: (context, history) {
        return FilteredHistory(
          history: history!
              .map(createHistoryTile)
              .where((element) => !element.hide)
              .toList(),
        );
      },
      loadingBuilder: (context) => SkeletonLoadingScreen(),
      errorBuilder: (context, error, stackTrace) => SkeletonLoadingScreen(),
    );
  }
}

HistoryTileData createHistoryTile(HistoryEntry historyEntry) {
  switch (historyEntry) {
    case AssessmentHistory():
      return getAssessmentHistoryTile(historyEntry);
    case ModuleHistory():
      return getModuleHistoryTile(historyEntry);
    case SessionHistory():
      return getSessionHistoryTile(historyEntry);
  }
}

HistoryTileData getAssessmentHistoryTile(AssessmentHistory historyEntry) {
  return HistoryTileData(
    assessmentSession: historyEntry.assessmentSession,
    module: null,
    session: null,
    title: "Selbsttest",
    iconData: Icons.check_box_outlined,
    subtitle: historyEntry.assessmentSession?.title ?? "Unbekannt",
    date: historyEntry.completed,
  );
}

HistoryTileData getModuleHistoryTile(ModuleHistory historyEntry) {
  return HistoryTileData(
    hide: historyEntry.module?.module.category != ModuleCategory.learning,
    session: null,
    assessmentSession: null,
    module: historyEntry.module,
    title: "Einheit",
    iconData: Icons.folder,
    subtitle: historyEntry.module?.module.title ?? "Unbekannt",
    date: historyEntry.completed,
  );
}

HistoryTileData getSessionHistoryTile(SessionHistory historyEntry) {
  return HistoryTileData(
    hide: historyEntry.module?.module.category != ModuleCategory.learning,
    session: historyEntry.session,
    module: historyEntry.module,
    assessmentSession: null,
    title: historyEntry.module?.module.title ?? "Unbekannt",
    iconData: Icons.chat,
    subtitle: historyEntry.session?.title ?? "Unbekannt",
    date: historyEntry.completed,
  );
}
