import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/widgets/planner_goal_tile.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerGoalsView extends ConsumerWidget {
  const PlannerGoalsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final goalsAsync = ref.watch(goalPodProvider);

    final skeleton = Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: SkeletonLoadingWidget(
        rows: 4,
        color: theme.colorScheme.tertiaryContainer,
      ),
    );

    return goalsAsync.build(
      context,
      loadingBuilder: (_) => skeleton,
      errorBuilder: (_, e, st) => skeleton,
      builder: (context, data) {
        final goals = (data?.values.toList() ?? [])
          ..sort((a, b) {
            if (a.fullfilled != b.fullfilled) {
              return a.fullfilled ? 1 : -1;
            }
            return a.createdAt.compareTo(b.createdAt);
          });

        if (goals.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 48,
                    color: theme.colorScheme.onTertiaryContainer.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    'Noch keine Ziele.\nTippe auf + um ein neues Ziel zu erstellen.',
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

        return ListView.builder(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: getBottomBarHeight(context),
          ),
          itemCount: goals.length,
          itemBuilder: (context, i) => PlannerGoalTile(goal: goals[i]),
        );
      },
    );
  }
}
