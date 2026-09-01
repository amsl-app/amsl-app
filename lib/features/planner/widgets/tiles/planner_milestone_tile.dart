import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/widgets/sheets/create_milestone_sheet.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_tile.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/themes/planner_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerMilestoneTile extends ConsumerWidget {
  const PlannerMilestoneTile({super.key, required this.milestone});

  final PlannerMilestone milestone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final planner = theme.plannerTheme;
    final goalNames = milestone.goals.map((g) => g.name).join(', ');

    return PlannerTile(
      dismissibleKey: ValueKey('milestone-${milestone.id}'),
      color: planner.milestoneAccentBackground,
      borderColor: planner.milestoneAccent.withValues(alpha: 0.3),
      onTap: () => showCreateMilestoneSheet(context, ref, milestone: milestone),
      onDelete: () => ref
          .read(milestonePodProvider.notifier)
          .deleteMilestone(milestone.id)
          .handle(context),
      leading: Icon(Icons.flag_rounded, color: planner.milestoneAccent),
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
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        if (goalNames.isNotEmpty)
          PlannerTileMetaRow(
            icon: Icons.emoji_events_outlined,
            text: goalNames,
            color: planner.milestoneAccent.withValues(alpha: 0.7),
          ),
      ],
    );
  }
}
