import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/widgets/create_goal_sheet.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerGoalTile extends ConsumerWidget {
  const PlannerGoalTile({super.key, required this.goal});

  final PlannerGoal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey('goal-${goal.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.onError),
      ),
      confirmDismiss: (_) async {
        // Fire-and-forget: the animation completes immediately. If the delete
        // fails, the provider state is unchanged and the goal reappears.
        ref.read(goalPodProvider.notifier).deleteGoal(goal.id).ignore();
        return true;
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: theme.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => showCreateGoalSheet(context, ref, goal: goal),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Checkbox(
                  value: goal.fullfilled,
                  activeColor: theme.colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (_) => ref
                      .read(goalPodProvider.notifier)
                      .updateGoal(goal.id, fullfilled: !goal.fullfilled),
                ),
                const Gap(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        goal.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: goal.fullfilled
                              ? TextDecoration.lineThrough
                              : null,
                          color: goal.fullfilled
                              ? theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                )
                              : null,
                        ),
                      ),
                      if (goal.description != null)
                        Text(
                          goal.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
