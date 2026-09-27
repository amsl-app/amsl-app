import 'package:amsl_app/features/transcript/repository/transcript_pdf_generator.dart';
import 'package:amsl_app/features/transcript/models/transcript_record.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TranscriptRecordTile extends StatelessWidget {
  final TranscriptRecord record;
  final String? userId;

  const TranscriptRecordTile({
    super.key,
    required this.record,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Same blue hue for both states, so a locked tile reads as a faded
    // version of its unlocked self rather than a different color entirely.
    // Unlocked uses the app's dark navy `primary` as a card background
    // (like a plaque), with the brighter secondaryContainer blue as the
    // badge accent on top. Yellow is reserved as a small, deliberate accent
    // (the met-requirement checkmarks below), not a second base color.
    final backgroundColor = record.unlocked
        ? colors.primary
        : colors.primary.withValues(alpha: 0.08);
    final badgeColor = record.unlocked
        ? colors.secondaryContainer
        : colors.secondaryContainer.withValues(alpha: 0.15);
    final textColor = record.unlocked
        ? colors.onPrimary
        : colors.onSurface.withValues(alpha: 0.15);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium, color: badgeColor, size: 28),
              const Gap(8),
              Expanded(
                child: Text(
                  record.title,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            record.description,
            style: theme.textTheme.bodyMedium!.copyWith(color: textColor),
          ),
          const Gap(12),
          ...record.requirements.map(
            (requirement) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(
                    requirement.met
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 18,
                    color: requirement.met
                        ? colors.tertiary
                        : colors.onSurface.withValues(alpha: 0.4),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      requirement.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: requirement.met ? colors.tertiary : null,
                        fontWeight: requirement.met ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (record.unlocked && userId != null) ...[
            const Gap(12),
            RoundedCornerButton(
              label: "Als PDF exportieren",
              icon: Icons.picture_as_pdf_outlined,
              buttonColor: colors.secondary,
              labelColor: colors.onSecondary,
              onTap: () =>
                  TranscriptPdfGenerator.exportRecord(record, userId: userId!),
            ),
          ],
        ],
      ),
    );
  }
}
