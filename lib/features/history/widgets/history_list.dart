import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'history_tile.dart';

class HistoryList extends HookConsumerWidget {
  final List<HistoryTileData> historyTilesData;

  const HistoryList({super.key, required this.historyTilesData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (historyTilesData.isNotEmpty) {
      final historyTiles = historyTilesData
          .mapIndexedAndLast(
            (i, e, isLast) =>
                HistoryTile(historyTileObject: e, first: i == 0, last: isLast),
          )
          .toList(growable: false);
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: historyTiles,
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Text(
              "Deine Historie ist leer",
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      );
    }
  }
}
