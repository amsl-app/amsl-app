import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/create_entry_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_priority_badge.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerEntryTile extends ConsumerWidget {
  const PlannerEntryTile({super.key, required this.entry});

  final PlannerEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moduleConfig = ref.watch(moduleConfigurationProviderProvider);

    final moduleMatch = entry.moduleId == null
        ? null
        : moduleConfig.value?.shownModules
              .where((m) => m.module.id == entry.moduleId)
              .firstOrNull;
    final moduleName = moduleMatch?.module.title;
    final sessionName = entry.sessionId == null
        ? null
        : moduleMatch?.module.sessions.values
              .where((s) => s.id == entry.sessionId)
              .firstOrNull
              ?.title;

    return Dismissible(
      key: ValueKey(entry.id),
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
        // fails, the provider state is unchanged and the entry reappears.
        ref
            .read(plannerProviderProvider.notifier)
            .deleteEntry(entry.id)
            .ignore();
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
          onTap: () => showCreateEntrySheet(context, ref, entry: entry),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Checkbox(
                  value: entry.completed,
                  activeColor: theme.colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (_) => ref
                      .read(plannerProviderProvider.notifier)
                      .updateEntry(entry.id, completed: !entry.completed),
                ),
                const Gap(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: entry.completed
                              ? TextDecoration.lineThrough
                              : null,
                          color: entry.completed
                              ? theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                )
                              : null,
                        ),
                      ),
                      if (moduleName != null)
                        Text(
                          sessionName != null
                              ? '$moduleName · $sessionName'
                              : moduleName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                if (entry.priority > 0) ...[
                  const Gap(8),
                  PlannerPriorityBadge(priority: entry.priority),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
