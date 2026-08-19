import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/widgets/create_milestone_sheet.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/themes/planner_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerMilestoneTile extends ConsumerWidget {
  const PlannerMilestoneTile({super.key, required this.milestone});

  final PlannerMilestone milestone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final planner = theme.plannerTheme;

    return Dismissible(
      key: ValueKey('milestone-${milestone.id}'),
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
        // fails, the provider state is unchanged and the milestone reappears.
        ref
            .read(milestonePodProvider.notifier)
            .deleteMilestone(milestone.id)
            .ignore();
        return true;
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: planner.milestoneAccentBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: planner.milestoneAccent.withValues(alpha: 0.3),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              showCreateMilestoneSheet(context, ref, milestone: milestone),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.flag_rounded, color: planner.milestoneAccent),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        milestone.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: planner.milestoneAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (milestone.description != null)
                        Text(
                          milestone.description!,
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
