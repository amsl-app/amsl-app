import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
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

  // Wraps sliver content with the overlap injector required by the
  // enclosing NestedScrollView (see planner_screen.dart) so this tab's
  // scrolling merges into the same scroll as the header/tab bar above it.
  Widget _sliverScrollView(BuildContext context, List<Widget> slivers) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        ...slivers,
      ],
    );
  }

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
      loadingBuilder: (_) =>
          _sliverScrollView(context, [SliverToBoxAdapter(child: skeleton)]),
      errorBuilder: (_, e, st) =>
          _sliverScrollView(context, [SliverToBoxAdapter(child: skeleton)]),
      builder: (context, data) {
        final entries = data?.entries ?? [];
        final milestones = data?.sortedMilestones ?? [];
        final goals = data?.goals.values.toList() ?? [];
        if (entries.isEmpty && milestones.isEmpty && goals.isEmpty) {
          return _sliverScrollView(context, [
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
                        'Noch keine Aktivitäten.\nTippe auf + um eine neue Aktivität zu erstellen.',
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

        return _sliverScrollView(context, [
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
                    ...dayGoals.map((g) => PlannerGoalTile(goal: g)),
                    const Gap(4),
                    ...dayMilestones.map(
                      (m) => PlannerMilestoneTile(milestone: m),
                    ),
                    const Gap(4),
                    ...dayEntries.map(
                      (entry) => PlannerEntryTile(entry: entry),
                    ),
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
