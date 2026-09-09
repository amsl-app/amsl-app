import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/sheets/create_entry_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_priority_badge.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_tile.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerEntryTile extends ConsumerWidget {
  const PlannerEntryTile({super.key, required this.entry});

  final PlannerEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final milestoneName = entry.milestone?.title;

    final isOverdue = !DateUtils.isSameDay(
      entry.scheduledDate,
      entry.effectiveDate,
    );

    return PlannerTile(
      dismissibleKey: ValueKey(entry.id),
      color: theme.colorScheme.surface,
      borderColor: isOverdue
          ? theme.colorScheme.error.withValues(alpha: 0.5)
          : theme.colorScheme.outline.withValues(alpha: 0.2),
      onTap: () => showCreateEntrySheet(context, ref, entry: entry),
      onDelete: () => ref
          .read(plannerPodProvider.notifier)
          .deleteEntry(entry.id)
          .handle(context),
      leading: Checkbox(
        value: entry.completed,
        activeColor: theme.colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) => ref
            .read(plannerPodProvider.notifier)
            .updateEntry(entry.id, completed: !entry.completed),
      ),
      leadingGap: 4,
      trailing: entry.priority > 0
          ? PlannerPriorityBadge(priority: entry.priority)
          : null,
      children: [
        Text(
          entry.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            decoration: entry.completed ? TextDecoration.lineThrough : null,
            color: entry.completed
                ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                : null,
          ),
        ),
        if (isOverdue)
          PlannerTileMetaRow(
            icon: Icons.error_outline,
            text:
                'Überfällig · ursprünglich '
                '${kNewDateFormat.format(entry.scheduledDate)}',
            color: theme.colorScheme.onError,
          ),
        if (milestoneName != null)
          PlannerTileMetaRow(
            icon: Icons.flag_rounded,
            text: milestoneName,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
