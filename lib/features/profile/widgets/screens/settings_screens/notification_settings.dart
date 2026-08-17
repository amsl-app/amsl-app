import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/features/profile/widgets/settings/setting_toggle.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../settings/day_time_picker.dart';
import '../../settings/time_picker.dart';

const _weekdayNames = {
  DateTime.monday: "Montag",
  DateTime.tuesday: "Dienstag",
  DateTime.wednesday: "Mittwoch",
  DateTime.thursday: "Donnerstag",
  DateTime.friday: "Freitag",
  DateTime.saturday: "Samstag",
  DateTime.sunday: "Sonntag",
};

final _dayOfMonthNames = {for (int day = 1; day <= 28; day++) day: "$day."};

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

    final daily_planning_permission =
        preferences.dailyPlanningNotificationEnabled;
    final daily_planning_time = preferences.dailyPlanningNotificationTime;

    final weekly_planning_permission =
        preferences.weeklyPlanningNotificationEnabled;
    final weekly_planning_day = preferences.weeklyPlanningNotificationDay;
    final weekly_planning_time = preferences.weeklyPlanningNotificationTime;

    final monthly_planning_permission =
        preferences.monthlyPlanningNotificationEnabled;
    final monthly_planning_day = preferences.monthlyPlanningNotificationDay;
    final monthly_planning_time = preferences.monthlyPlanningNotificationTime;

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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Erinnerungen",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const Gap(16.0),
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
              const Gap(32),
              const Divider(),
              const Gap(16.0),
              Text(
                "Planung",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const Gap(16.0),
              Text("Wochenplanung:", style: theme.textTheme.titleMedium!),
              const Gap(12.0),
              DayTimePicker(
                label:
                    "Erhalte eine Erinnerung, deine Woche zu planen",
                dayOptions: _weekdayNames,
                onDayChange: (int day) {
                  notifier.setWeeklyPlanningNotificationDay(day);
                },
                onTimeChange: (TimeOfDay time) {
                  notifier.setWeeklyPlanningNotificationTime(time);
                  showMessage(
                    context,
                    label:
                        "Die Erinnerung wird jetzt um ${time.format(context)} gesendet.",
                  );
                },
                onToggle: (bool toggle) {
                  notifier.setWeeklyPlanningNotificationPermission(toggle);
                  showMessage(
                    context,
                    label: toggle
                        ? "Du hast die Erinnerung aktiviert."
                        : "Du hast die Erinnerung deaktiviert.",
                  );
                },
                initDay: weekly_planning_day,
                initTime: weekly_planning_time,
                initToggle: weekly_planning_permission,
              ),
              const Gap(24),
              Text("Monatsplanung:", style: theme.textTheme.titleMedium!),
              const Gap(12.0),
              DayTimePicker(
                label:
                    "Erhalte eine Erinnerung, deinen Monat zu planen",
                dayOptions: _dayOfMonthNames,
                onDayChange: (int day) {
                  notifier.setMonthlyPlanningNotificationDay(day);
                },
                onTimeChange: (TimeOfDay time) {
                  notifier.setMonthlyPlanningNotificationTime(time);
                  showMessage(
                    context,
                    label:
                        "Die Erinnerung wird jetzt um ${time.format(context)} gesendet.",
                  );
                },
                onToggle: (bool toggle) {
                  notifier.setMonthlyPlanningNotificationPermission(toggle);
                  showMessage(
                    context,
                    label: toggle
                        ? "Du hast die Erinnerung aktiviert."
                        : "Du hast die Erinnerung deaktiviert.",
                  );
                },
                initDay: monthly_planning_day,
                initTime: monthly_planning_time,
                initToggle: monthly_planning_permission,
              ),
              const Gap(24),
              Text("Tagesplanung:", style: theme.textTheme.titleMedium!),
              const Gap(12.0),
              TimePicker(
                label: "Erhalte täglich eine Erinnerung, deinen Tag zu planen",
                onTimeChange: (TimeOfDay time) {
                  notifier.setDailyPlanningNotificationTime(time);
                  showMessage(
                    context,
                    label:
                        "Die Erinnerung wird jetzt um ${time.format(context)} gesendet.",
                  );
                },
                onToggle: (bool toggle) {
                  notifier.setDailyPlanningNotificationPermission(toggle);
                  showMessage(
                    context,
                    label: toggle
                        ? "Du hast die Erinnerung aktiviert."
                        : "Du hast die Erinnerung deaktiviert.",
                  );
                },
                initTime: daily_planning_time,
                initToggle: daily_planning_permission,
              ),
              Gap(getBottomBarPadding(context))
            ],
          ),
        ),
      ),
    );
  }
}
