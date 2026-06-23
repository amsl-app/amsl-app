import 'package:amsl_app/features/notifications/utils.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/create_entry_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_priority_badge.dart';
import 'package:amsl_app/screens/home/home_chip.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PlannerHomeCard extends ConsumerWidget {
  const PlannerHomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEntries = ref.watch(plannerProviderProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: asyncEntries.build(
          context,
          builder: (context, entries) {
            final startOfToday = DateTime.now().withoutTime();
            final upcoming =
                (entries ?? [])
                    .where(
                      (e) => !e.completed && !e.date.isBefore(startOfToday),
                    )
                    .toList()
                  ..sort((a, b) => a.date.compareTo(b.date));

            return _buildContent(context, ref, upcoming.take(2).toList());
          },
          loadingBuilder: (context) => _buildContent(context, ref, const []),
          errorBuilder: (context, _, _) =>
              _buildContent(context, ref, const []),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<PlannerEntry> shown,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            HomeChip(
              label: 'Planner',
              backgroundColor: colorScheme.tertiary,
              textColor: colorScheme.onTertiary,
            ),
            const Spacer(),
            Icon(Icons.calendar_today_outlined, color: colorScheme.primary),
          ],
        ),
        const Gap(16),
        if (shown.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Keine anstehenden Aufgaben',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onTertiaryContainer.withValues(alpha: 0.5),
              ),
            ),
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < shown.length; i++) ...[
                if (i > 0) const Gap(8),
                _TaskRow(entry: shown[i]),
              ],
            ],
          ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: RoundedCornerButton(
                label: 'Hinzufügen',
                icon: Icons.auto_fix_high,
                buttonColor: colorScheme.primary,
                labelColor: colorScheme.onPrimary,
                onTap: () => showCreateEntrySheet(context, ref),
              ),
            ),
            const Gap(8),
            Expanded(
              child: RoundedCornerButton(
                label: 'Details',
                icon: Icons.arrow_forward,
                buttonColor: colorScheme.onTertiaryContainer.withValues(
                  alpha: 0.1,
                ),
                labelColor: colorScheme.onTertiaryContainer,
                onTap: () => context.pushNamed('planner'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.entry});

  final PlannerEntry entry;

  Color _priorityColor(ColorScheme cs) => entry.priority == 0
      ? cs.onTertiaryContainer.withValues(alpha: 0.2)
      : PlannerPriorityBadge.priorityColor(entry.priority);

  String _dateLabel() {
    final diff = entry.date
        .withoutTime()
        .difference(DateTime.now().withoutTime())
        .inDays;
    return switch (diff) {
      0 => 'Heute',
      1 => 'Morgen',
      _ => DateFormat('EEE', 'de').format(entry.date),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isToday = entry.date.isToday();

    return Row(
      children: [
        Container(
          width: 3,
          height: 36,
          decoration: BoxDecoration(
            color: _priorityColor(colorScheme),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Text(
            entry.title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onTertiaryContainer,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Gap(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isToday
                ? colorScheme.tertiary
                : colorScheme.onTertiaryContainer.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _dateLabel(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: isToday
                  ? colorScheme.onTertiary
                  : colorScheme.onTertiaryContainer.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
