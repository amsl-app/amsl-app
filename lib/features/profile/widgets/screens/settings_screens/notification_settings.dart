import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/features/profile/widgets/settings/setting_toggle.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../settings/time_picker.dart';

class NotificationSettings extends StatefulHookConsumerWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState<NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final preferences = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);

    final notification_permission = preferences.notificationEnabled;
    final notification_time = preferences.notificationTime;

    final session_lock_notification_permission =
        preferences.sessionLockNotificationEnabled;

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benachrichtigungen",
                    style: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: theme.colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Erinnerung:", style: theme.textTheme.titleMedium!),
              const Gap(12.0),
              TimePicker(
                label:
                    "Erhalte eine Erinnerung, wenn du die App längere Zeit nicht benutzt hast",
                onTimeChange: (TimeOfDay time) {
                  notifier.setNotificationTime(time);
                  showMessage(
                    context,
                    label:
                        "Die Erinnerung wird jetzt um ${time.format(context)} gesendet.",
                  );
                },
                onToggle: (bool toggle) {
                  notifier.setNotificationPermission(toggle);
                  showMessage(
                    context,
                    label: toggle
                        ? "Du hast die Erinnerung aktiviert."
                        : "Du hast die Erinnerung deaktiviert.",
                  );
                },
                initTime: notification_time,
                initToggle: notification_permission,
              ),
              const Gap(24),
              Text(
                "Unterhaltung verfügbar:",
                style: theme.textTheme.titleMedium!,
              ),
              const Gap(12.0),
              SettingsToggle(
                label:
                    "Erhalte eine Benachrichtigung, wenn eine neue Unterhaltung verfügbar ist",
                onToggle: (bool toggle) {
                  notifier.setSessionLockNotificationPermission(toggle);
                  showMessage(
                    context,
                    label: toggle
                        ? "Du hast die Benachrichtigung aktiviert."
                        : "Du hast die Benachrichtigung deaktiviert.",
                  );
                },
                initToggle: session_lock_notification_permission,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
