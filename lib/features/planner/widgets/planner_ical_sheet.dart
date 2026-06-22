import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PlannerIcalSheet extends ConsumerWidget {
  const PlannerIcalSheet({super.key});

  String _buildIcalUrl(String token) =>
      '${ApiConstants.schemeString}://${ApiConstants.baseUrl}/${ApiConstants.apiPath}/planner/ical/$token';

  String _buildWebcalUrl(String token) =>
      'webcal://${ApiConstants.baseUrl}/${ApiConstants.apiPath}/planner/ical/$token';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tokenAsync = ref.watch(icalTokenProviderProvider);

    return tokenAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            e is HikariException ? e.message : 'Fehler beim Laden',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (token) {
        if (token == null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kein Kalender-Link vorhanden.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              RoundedCornerButton(
                label: 'Link generieren',
                buttonColor: theme.colorScheme.primary,
                labelColor: theme.colorScheme.onPrimary,
                onTap: () async {
                  try {
                    await ref
                        .read(icalTokenProviderProvider.notifier)
                        .regenerate();
                  } on HikariException catch (_) {
                    if (context.mounted) showMessage(context, error: true);
                  }
                },
              ),
            ],
          );
        }

        final url = _buildIcalUrl(token);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kalender abonnieren',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              'Kopiere den Link und füge ihn in deiner Kalender-App ein, um deinen Planer zu abonnieren.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      url,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Gap(8),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: url));
                    if (context.mounted) {
                      showMessage(context, label: 'Link kopiert');
                    }
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: 'Kopieren',
                ),
              ],
            ),
            const Gap(16),
            RoundedCornerButton(
              label: 'Im Kalender öffnen',
              icon: Icons.calendar_month_outlined,
              buttonColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.onPrimary,
              onTap: () async {
                final webcalUri = Uri.parse(_buildWebcalUrl(token));
                if (!await launchUrl(webcalUri)) {
                  if (context.mounted) {
                    showMessage(
                      context,
                      label: 'Kalender-App konnte nicht geöffnet werden',
                      error: true,
                    );
                  }
                }
              },
            ),
            const Gap(8),
            Center(
              child: TextButton(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Link widerrufen?'),
                      content: const Text(
                        'Der aktuelle Kalender-Link wird ungültig. Du kannst anschließend einen neuen Link generieren.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Abbrechen'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text(
                            'Widerrufen',
                            style: TextStyle(
                              color: theme.colorScheme.onError,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    try {
                      await ref
                          .read(icalTokenProviderProvider.notifier)
                          .revoke();
                    } on HikariException catch (_) {
                      if (context.mounted) showMessage(context, error: true);
                    }
                  }
                },
                child: Text(
                  'Link widerrufen',
                  style: TextStyle(color: theme.colorScheme.onError),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void showPlannerIcalSheet(BuildContext context, WidgetRef ref) {
  showAmslBottomSheet(
    context: context,
    child: const PlannerIcalSheet(),
    onClose: () => Navigator.of(context).pop(),
    bottomBar: true,
  );
}
