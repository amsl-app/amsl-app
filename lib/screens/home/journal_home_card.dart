import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/notifications/utils.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/screens/home/home_chip.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalHomeCard extends ConsumerWidget {
  const JournalHomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variant = ref.watch(variantPodProvider);

    return variant.build(
      context,
      builder: (context, v) {
        if (!v!.journalEnabled) return const SizedBox.shrink();
        return _JournalCard();
      },

      loadingBuilder: (context) => const SizedBox.shrink(),
      errorBuilder: (context, _, _) => const SizedBox.shrink(),
    );
  }
}

class _JournalCard extends ConsumerWidget {
  const _JournalCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJournal = ref.watch(journalProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: asyncJournal.build(
          context,
          builder: (context, entries) => _buildContent(context, entries ?? []),
          loadingBuilder: (context) => _buildContent(context, []),
          errorBuilder: (context, _, _) => _buildContent(context, []),
        ),
      ),
    );
  }

  int _computeStreak(List<ToriJournalEntry> entries, DateTime today) {
    final hasTodayEntry = entries.any((e) => e.created.sameDayAs(today));
    int streak = 0;
    for (int i = hasTodayEntry ? 0 : 1; ; i++) {
      final day = DateTime(today.year, today.month, today.day - i);
      final hasEntry = entries.any((e) => e.created.sameDayAs(day));
      if (!hasEntry) break;
      streak++;
    }
    return streak;
  }

  Widget _buildContent(BuildContext context, List<ToriJournalEntry> entries) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final today = DateTime.now();
    final streak = _computeStreak(entries, today);
    final lastFiveDays = List.generate(
      5,
      (i) => DateTime(today.year, today.month, today.day - (4 - i)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            HomeChip(
              label: 'Lernjournal',
              backgroundColor: colorScheme.tertiary,
              textColor: colorScheme.onTertiary,
            ),
            const Spacer(),
            Icon(Icons.local_fire_department, color: colorScheme.primary),
          ],
        ),
        const Gap(12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$streak Tage Streak',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
            const Spacer(),
            for (final day in lastFiveDays) ...[
              const Gap(4),
              _DayDot(active: entries.any((e) => e.created.sameDayAs(day))),
            ],
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: RoundedCornerButton(
                label: 'Reflektieren',
                icon: Icons.edit_outlined,
                buttonColor: colorScheme.primary,
                labelColor: colorScheme.onPrimary,
                onTap: () => context.pushNamed(
                  'reflection',
                ), // TODO continue or create new entry directly
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
                onTap: () => context.pushNamed('reflection'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? colorScheme.primary
            : colorScheme.onTertiaryContainer.withValues(alpha: 0.2),
      ),
    );
  }
}
