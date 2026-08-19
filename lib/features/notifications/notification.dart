import 'dart:async';
import 'dart:convert';
import 'package:amsl_app/features/notifications/utils.dart';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/models/tori/modules/module_configuration.dart';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const title = "Hallo! Hier ist die AMSL";
const fullReminderwBody =
    "Schau doch mal vorbei es warten spannende Lernmodule & Tools auf dich.";
const dailyPlanningBody = "Zeit, deinen Tag zu planen.";
const weeklyPlanningBody = "Zeit, deine Woche zu planen.";
const monthlyPlanningBody = "Zeit, deinen Monat zu planen.";

const sessionUnlockMaxCount = 5;

enum NotificationType {
  reminder(offset: sessionUnlockMaxCount),
  session(offset: 0),
  dailyPlanning(offset: sessionUnlockMaxCount + 7),
  weeklyPlanning(offset: sessionUnlockMaxCount + 8),
  monthlyPlanning(offset: sessionUnlockMaxCount + 9);

  const NotificationType({required this.offset});

  final int offset;
}

class NotificationService {
  static final log = Logger('NotificationService');

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'amsl_channel',
      'AMSL Notifications',
      channelDescription: 'Notifications for AMSL app',
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> initNotifications() async {
    //init notificationSettings
    if (_flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >() !=
        null) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }
    InitializationSettings initializationSettings =
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/launcher_icon'),
          iOS: DarwinInitializationSettings(),
        );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    //init timeZone for scheduled notifications
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));
    } catch (e) {
      // If fetching the device timezone fails, fallback to UTC or a default
      log.warning("Could not set local timezone: $e");
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
    log.info("NotificationService initialized with timezone: ${tz.local.name}");
  }

  void recreateNotifications(
    PreferencesState state, {
    ModuleConfiguration? moduleConfig,
  }) async {
    final log = Logger("NotificationStateProvider - recreateNotifications");
    log.fine("Recreate Notifications");
    await NotificationService().cancelNotification();

    // Session Lock Notifications
    if (state.sessionLockNotificationEnabled) {
      final lockedSessions = moduleConfig?.lockedSessions.where(
        (session) =>
            session.lockedUntil != null && session.lockedUntil!.time != null,
      );

      Iterable<(DateTime, String, String)> unlockTimes =
          lockedSessions?.map(
            (e) => (e.lockedUntil!.time!, e.module.target!.title, e.title),
          ) ??
          [];

      // Take only the next 5 sessions that will be unlocked and ignore past sessions
      unlockTimes = unlockTimes.where((e) => e.$1.isAfter(DateTime.now()));

      for (final (id, session)
          in unlockTimes.take(sessionUnlockMaxCount).indexed) {
        await _setupDatedNotification(
          title: title,
          content:
              "Die Unterhaltung '${session.$3}'' im Modul '${session.$2}'' ist jetzt verfügbar. Schaue sie dir doch mal an.",
          payload: jsonEncode({"route": "module", "param": session.$2}),
          time: session.$1,
          type: NotificationType.session,
          id: id,
          isUtc: true,
        );
      }
    }

    // Reminder Notifications
    if (state.notificationEnabled) {
      createReminderNotifications(notificationTime: state.notificationTime);
    }

    // Planning Notifications
    if (state.dailyPlanningNotificationEnabled) {
      await createDailyPlanningNotification(
        time: state.dailyPlanningNotificationTime,
      );
    }
    if (state.weeklyPlanningNotificationEnabled) {
      await createWeeklyPlanningNotification(
        weekday: state.weeklyPlanningNotificationDay,
        time: state.weeklyPlanningNotificationTime,
      );
    }
    if (state.monthlyPlanningNotificationEnabled) {
      await createMonthlyPlanningNotification(
        dayOfMonth: state.monthlyPlanningNotificationDay,
        time: state.monthlyPlanningNotificationTime,
      );
    }
  }

  Future createDailyPlanningNotification({required TimeOfDay time}) async {
    var next = DateTime.now().withTime(time);
    if (next.isBefore(DateTime.now())) {
      next = next.add(const Duration(days: 1));
    }

    await _setupRecurringNotification(
      title: title,
      content: dailyPlanningBody,
      payload: jsonEncode({"route": "planner"}),
      time: next,
      type: NotificationType.dailyPlanning,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future createWeeklyPlanningNotification({
    required int weekday,
    required TimeOfDay time,
  }) async {
    var next = DateTime.now().withTime(time);
    while (next.weekday != weekday || next.isBefore(DateTime.now())) {
      next = next.add(const Duration(days: 1));
    }

    await _setupRecurringNotification(
      title: title,
      content: weeklyPlanningBody,
      payload: jsonEncode({"route": "planner"}),
      time: next,
      type: NotificationType.weeklyPlanning,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future createMonthlyPlanningNotification({
    required int dayOfMonth,
    required TimeOfDay time,
  }) async {
    var next = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      dayOfMonth,
    ).withTime(time);
    if (next.isBefore(DateTime.now())) {
      next = DateTime(next.year, next.month + 1, dayOfMonth).withTime(time);
    }

    await _setupRecurringNotification(
      title: title,
      content: monthlyPlanningBody,
      payload: jsonEncode({"route": "planner"}),
      time: next,
      type: NotificationType.monthlyPlanning,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  Future _setupRecurringNotification({
    required String title,
    required String content,
    required String payload,
    required DateTime time,
    required NotificationType type,
    required DateTimeComponents matchDateTimeComponents,
  }) async {
    final date = tz.TZDateTime(
      tz.local,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
    );
    log.info("Set $type notification for: $date (recurring)");
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: type.offset,
      title: title,
      body: content,
      scheduledDate: date,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  // 3 times daily; 2 times every 3 days; 2 times every 7 days
  Future createReminderNotifications({
    required TimeOfDay notificationTime,
  }) async {
    List<DateTime> days = [];

    final today = DateTime.now()
        .subtract(const Duration(hours: 2))
        .withoutTime();

    // Setup the next 7 notifications with increasing intervals
    for (int i = 0; i < 7; i++) {
      late Duration duration;
      if (i < 3) {
        duration = const Duration(days: 1);
      } else if (i < 5) {
        duration = const Duration(days: 3);
      } else {
        duration = const Duration(days: 7);
      }
      final lastDay = days.isEmpty ? today : days.last;

      days.add(lastDay.add(duration));
    }

    for (final (i, date) in days.indexed) {
      DateTime nextNotification = date.withTime(notificationTime);

      await _setupDatedNotification(
        title: title,
        content: fullReminderwBody,
        payload: jsonEncode({"route": "home"}),
        time: nextNotification,
        type: NotificationType.reminder,
        id: i,
        isUtc: false,
      );
    }
  }

  Future _setupDatedNotification({
    required String title,
    required String content,
    required String payload,
    required DateTime time,
    required NotificationType type,
    required int id,
    required bool isUtc,
  }) async {
    final localTime = isUtc ? time.toLocal() : time;

    tz.TZDateTime date = tz.TZDateTime(
      tz.local,
      localTime.year,
      localTime.month,
      localTime.day,
      localTime.hour,
      localTime.minute,
    );
    log.info("Set $type notification for: $date");
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: type.offset + id,
      title: title,
      body: content,
      scheduledDate: date,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
    removeBadge();
  }

  Future<void> removeBadge() async {
    if (await AppBadgePlus.isSupported()) {
      AppBadgePlus.updateBadge(1);
    }
    AppBadgePlus.updateBadge(0);
  }
}
