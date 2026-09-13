import 'package:amsl_app/features/transcript/repository/transcript_pdf_generator.dart';
import 'package:amsl_app/models/tori/transcript/transcript_record.dart';
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
    final textColor = record.unlocked
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withValues(alpha: 0.5);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            record.title,
            style: theme.textTheme.titleMedium!.copyWith(color: textColor),
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
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      requirement.label,
                      style: theme.textTheme.bodySmall,
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
              buttonColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.onPrimary,
              onTap: () =>
                  TranscriptPdfGenerator.exportRecord(record, userId: userId!),
            ),
          ],
        ],
      ),
    );
  }
}
