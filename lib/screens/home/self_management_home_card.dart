import 'package:amsl_app/features/assessment/providers/assessment_sessions.dart';
import 'package:amsl_app/features/self_management/widgets/score_track_row.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/screens/home/home_chip.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelfManagementHomeCard extends ConsumerWidget {
  const SelfManagementHomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSessions = ref.watch(assessmentSessionsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: asyncSessions.build(
          context,
          builder: (context, sessions) {
            final finished =
                (sessions?.values.toList() ?? <ToriAssessmentSession>[])
                    .where(
                      (s) =>
                          s.status ==
                              hikari_assessment.AssessmentStatus.finished &&
                          s.completed != null,
                    )
                    .toList()
                  ..sort((a, b) => b.completed!.compareTo(a.completed!));

            return _buildContent(
              context,
              finished.isEmpty ? null : finished.first,
            );
          },
          loadingBuilder: (context) => _buildContent(context, null),
          errorBuilder: (context, _, _) => _buildContent(context, null),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ToriAssessmentSession? session) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onCard = colorScheme.onTertiaryContainer;
    final scoredScales =
        session?.scales.where((s) => s.value != null).toList() ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            HomeChip(
              label: 'Selbstmanagement',
              backgroundColor: colorScheme.tertiary,
              textColor: colorScheme.onTertiary,
            ),
            const Spacer(),
            Icon(Icons.psychology_outlined, color: colorScheme.primary),
          ],
        ),
        const Gap(16),
        if (scoredScales.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Noch keine Selbsttests abgeschlossen',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: onCard.withValues(alpha: 0.5),
              ),
            ),
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < scoredScales.length; i++) ...[
                if (i > 0) const Gap(12),
                Text(
                  scoredScales[i].title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: onCard.withValues(alpha: 0.65),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                ScoreTrackRow(
                  label: '',
                  value: scoredScales[i].value!,
                  min: scoredScales[i].min,
                  max: scoredScales[i].max,
                  trackColor: onCard.withValues(alpha: 0.15),
                  fillColor: colorScheme.primary,
                  dotColor: colorScheme.primary,
                  valueStyle: theme.textTheme.bodySmall?.copyWith(
                    color: onCard,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: RoundedCornerButton(
                label: 'Jetzt testen',
                icon: Icons.psychology_outlined,
                buttonColor: colorScheme.primary,
                labelColor: colorScheme.onPrimary,
                onTap: () => context.pushNamed('self_management'),
              ),
            ),
            const Gap(8),
            Expanded(
              child: RoundedCornerButton(
                label: 'Details',
                icon: Icons.arrow_forward,
                buttonColor: onCard.withValues(alpha: 0.1),
                labelColor: onCard,
                onTap: () => context.pushNamed('self_management'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
