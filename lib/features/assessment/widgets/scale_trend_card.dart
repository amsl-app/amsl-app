import 'package:amsl_app/features/assessment/widgets/data_points_sheet.dart';
import 'package:amsl_app/features/assessment/widgets/scale_series.dart';
import 'package:amsl_app/features/assessment/widgets/scale_sparkline.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// A single scale's small multiple: title, a compact sparkline, and a
/// badge with its latest value. Tapping it opens the raw datapoints.
class ScaleTrendCard extends StatelessWidget {
  final ScaleSeries series;

  const ScaleTrendCard({super.key, required this.series});

  Future<void> _openDataPoints(BuildContext context) async {
    await showAmslBottomSheet(
      context: context,
      bottomBar: true,
      onClose: () => context.pop(),
      child: ScaleDataPointsSheet(scale: series.scale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latest = series.latestValue;
    final reference = series.scale.reference;
    final normalizedReference = reference == null
        ? null
        : normalizeScaleValue(reference, series.scale);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openDataPoints(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(series.scale.title, style: theme.textTheme.titleSmall),
                  const Gap(8),
                  SizedBox(
                    height: 36,
                    child: series.spots.isEmpty
                        ? null
                        : ScaleSparkline(
                            spots: series.spots,
                            color: series.color,
                            referenceY: normalizedReference,
                          ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Aktuell",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: series.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    latest == null ? "–" : latest.toStringAsFixed(1),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: series.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (normalizedReference != null) ...[
                  const Gap(4),
                  Text(
                    "Ø ${normalizedReference.toStringAsFixed(1)}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
