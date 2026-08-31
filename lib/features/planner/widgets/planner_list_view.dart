import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
import 'package:amsl_app/features/planner/widgets/planner_sliver_helpers.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_entry_tile.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_goal_tile.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_milestone_tile.dart';
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
      loadingBuilder: (_) => plannerSliverScrollView(context, [
        SliverToBoxAdapter(child: skeleton),
      ]),
      errorBuilder: (_, e, st) => plannerSliverScrollView(context, [
        SliverToBoxAdapter(child: skeleton),
      ]),
      builder: (context, data) {
        final entries = data?.entries ?? [];
        final milestones = data?.sortedMilestones ?? [];
        final goals = data?.goals.values.toList() ?? [];
        if (entries.isEmpty && milestones.isEmpty && goals.isEmpty) {
          return plannerSliverScrollView(context, [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
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
                        'Noch keine Ziele, Meilensteine oder Aktivitäten.\nTippe auf + und fange am besten mit deinem ersten Ziel an.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onTertiaryContainer
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
        }

        final entriesByDay = groupEntriesByDay(entries);
        final milestonesByDay = groupMilestonesByDay(milestones);
        final goalsByDay = groupGoalsByDay(goals);
        final keys = mergedDayKeys(
          entriesByDay.keys,
          milestonesByDay.keys,
          goalsByDay.keys,
        );

        return plannerSliverScrollView(context, [
          SliverPadding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
              bottom: getBottomBarHeight(context),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                final date = keys[i];
                final dayEntries = entriesByDay[date] ?? [];
                final dayMilestones = milestonesByDay[date] ?? [];
                final dayGoals = goalsByDay[date] ?? [];
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
                    ...intersperseGroups([
                      dayGoals.map((g) => PlannerGoalTile(goal: g)).toList(),
                      dayMilestones
                          .map((m) => PlannerMilestoneTile(milestone: m))
                          .toList(),
                      dayEntries
                          .map((entry) => PlannerEntryTile(entry: entry))
                          .toList(),
                    ]),
                  ],
                );
              }, childCount: keys.length),
            ),
          ),
        ]);
      },
    );
  }
}
