import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/self_management/models/score_entry.dart';
import 'package:amsl_app/features/self_management/providers/competency_groups_provider.dart';
import 'package:amsl_app/features/self_management/widgets/score_track_row.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelfManagementScreen extends ConsumerWidget {
  const SelfManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGroups = ref.watch(competencyGroupsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selbstmanagement'),
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.tertiaryContainer,
      ),
      body: asyncGroups.build(
        context,
        builder: (context, groups) {
          if (groups == null || groups.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Noch keine Selbsttests abgeschlossen',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in groups.entries) ...[
                    _CompetencyGroup(
                      title: entry.key,
                      entries: entry.value,
                    ),
                    const Gap(24),
                  ],
                  Gap(getBottomBarPadding(context)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CompetencyGroup extends StatelessWidget {
  const _CompetencyGroup({required this.title, required this.entries});

  final String title;
  final List<ScoreEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < entries.length; i++) ...[
                if (i > 0) ...[
                  const Gap(10),
                  Divider(
                    height: 1,
                    color: colorScheme.onTertiaryContainer.withValues(alpha: 0.15),
                  ),
                  const Gap(10),
                ],
                _ScoreEntryRow(entry: entries[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ScoreEntryRow extends StatelessWidget {
  const _ScoreEntryRow({required this.entry});

  final ScoreEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onCard = colorScheme.onTertiaryContainer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                entry.assessmentTitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: onCard.withValues(alpha: 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              kNewDateFormat.format(entry.completed),
              style: theme.textTheme.bodySmall?.copyWith(
                color: onCard.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
        const Gap(8),
        ScoreTrackRow(
          label: '',
          value: entry.value,
          min: entry.min,
          max: entry.max,
          trackColor: onCard.withValues(alpha: 0.15),
          fillColor: colorScheme.primary,
          dotColor: colorScheme.primary,
          valueStyle: theme.textTheme.bodySmall?.copyWith(
            color: onCard,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
