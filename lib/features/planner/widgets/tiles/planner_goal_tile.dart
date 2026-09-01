import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/widgets/sheets/create_goal_sheet.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_tile.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/themes/planner_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerGoalTile extends ConsumerWidget {
  const PlannerGoalTile({super.key, required this.goal});

  final PlannerGoal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final planner = theme.plannerTheme;

    return PlannerTile(
      dismissibleKey: ValueKey('goal-${goal.id}'),
      color: planner.goalAccentBackground,
      borderColor: planner.goalAccent.withValues(alpha: 0.3),
      onTap: () => showCreateGoalSheet(context, ref, goal: goal),
      onDelete: () => ref
          .read(goalPodProvider.notifier)
          .deleteGoal(goal.id)
          .handle(context),
      leading: Icon(
        Icons.emoji_events_outlined,
        color: goal.fulfilled
            ? planner.goalAccent.withValues(alpha: 0.5)
            : planner.goalAccent,
      ),
      children: [
        Text(
          goal.name,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            decoration: goal.fulfilled ? TextDecoration.lineThrough : null,
            color: goal.fulfilled
                ? planner.goalAccent.withValues(alpha: 0.5)
                : planner.goalAccent,
          ),
        ),
        if (goal.description != null)
          Text(
            goal.description!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: planner.goalAccent.withValues(alpha: 0.7),
            ),
          ),
      ],
    );
  }
}
