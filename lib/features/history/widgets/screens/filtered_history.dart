import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../constants.dart';
import '../../../../widgets/search_widget.dart';
import '../../providers/history_provider.dart';
import '../history_list.dart';
import '../history_tile.dart';

class FilteredHistory extends StatefulHookConsumerWidget {
  final List<HistoryTileData> history;

  const FilteredHistory({super.key, required this.history});

  @override
  ConsumerState<FilteredHistory> createState() => _FilteredHistoryState();
}

class _FilteredHistoryState extends ConsumerState<FilteredHistory> {
  String keyword = "";
  List<HistoryTileData> historyTilesData = [];

  @override
  Widget build(BuildContext context) {
    filterHistoryTiles(keyword);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              SearchWidget(
                onChange: (value) {
                  if (mounted) {
                    setState(() {
                      keyword = value;
                    });
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: HapticRefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(historyProviderProvider.notifier)
                    .reloadHistory(complete: true);
              },
              child: HistoryList(historyTilesData: historyTilesData),
            ),
          ),
          Gap(getBottomBarHeight(context)),
        ],
      ),
    );
  }

  void filterHistoryTiles(String keyword) {
    List<HistoryTileData> tempHistory = [];
    tempHistory.addAll(widget.history);

    if (keyword.isNotEmpty) {
      for (int i = 0; i < tempHistory.length; i++) {
        if (!tempHistory[i].contains(keyword.toLowerCase())) {
          tempHistory.removeAt(i);
          i--;
        }
      }
    }
    historyTilesData.clear();
    historyTilesData.addAll(tempHistory);
  }
}
