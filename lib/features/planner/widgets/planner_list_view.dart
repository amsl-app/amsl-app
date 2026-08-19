import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
import 'package:amsl_app/features/planner/widgets/planner_entry_tile.dart';
import 'package:amsl_app/features/planner/widgets/planner_milestone_tile.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerListView extends ConsumerWidget {
  const PlannerListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final configAsync = ref.watch(plannerConfigPodProvider);

    final skeleton = Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: SkeletonLoadingWidget(
        rows: 4,
        color: theme.colorScheme.tertiaryContainer,
      ),
    );

    return configAsync.build(
      context,
      loadingBuilder: (_) => skeleton,
      errorBuilder: (_, e, st) => skeleton,
      builder: (context, data) {
        final entries = data?.entries ?? [];
        final milestones = data?.sortedMilestones ?? [];
        if (entries.isEmpty && milestones.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 48,
                    color: theme.colorScheme.onTertiaryContainer.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Noch keine Einträge.\nTippe auf + um einen neuen Eintrag zu erstellen.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final entriesByDay = groupEntriesByDay(entries);
        final milestonesByDay = groupMilestonesByDay(milestones);
        final keys = mergedDayKeys(entriesByDay.keys, milestonesByDay.keys);

        return ListView.builder(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: getBottomBarHeight(context),
          ),
          itemCount: keys.length,
          itemBuilder: (context, i) {
            final date = keys[i];
            final dayEntries = entriesByDay[date] ?? [];
            final dayMilestones = milestonesByDay[date] ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 4),
                  child: Text(
                    kNewDateFormat.format(date),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                ...dayMilestones.map((m) => PlannerMilestoneTile(milestone: m)),
                ...dayEntries.map((entry) => PlannerEntryTile(entry: entry)),
              ],
            );
          },
        );
      },
    );
  }
}
