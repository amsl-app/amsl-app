import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.freezed.dart';
part 'preferences.g.dart';

@freezed
abstract class PreferencesState with _$PreferencesState {
  const factory PreferencesState({
    required bool trackingPermission,
    required bool crashReportingPermission,
    required final TimeOfDay notificationTime,
    required final bool notificationEnabled,
    required final bool sessionLockNotificationEnabled,
    required bool? activateClickableSession,
    required String? templateCourse,
    required bool? showRestartInCourse,
    required bool? statusBarDisabled,
  }) = _PreferencesState;

  const PreferencesState._();

  factory PreferencesState.fromSharedPreferences(
    SharedPreferences sharedPreferences,
  ) {
    final bool trackingPermission =
        sharedPreferences.getBool(StorageKey.allowTracking.key) ?? false;

    final bool crashReportingPermission =
        sharedPreferences.getBool(StorageKey.allowCrashReporting.key) ?? false;

    final TimeOfDay notificationTime = TimeOfDay(
      hour:
          (sharedPreferences.get(StorageKey.notificationTimeHour.key) ?? 21)
              as int,
      minute:
          (sharedPreferences.get(StorageKey.notificationTimeMinute.key) ?? 00)
              as int,
    );
    final bool notificationEnabled =
        (sharedPreferences.get(StorageKey.notificationEnabled.key) ?? true)
            as bool;

    final bool sessionLockNotificationEnabled =
        (sharedPreferences.get(StorageKey.sessionLockNotificationEnabled.key) ??
                true)
            as bool;

    bool? activateClickableSession;
    bool? showRestartInCourse;
    String? templateCourse;
    bool? statusBarDisabled;

    if (kDebugMode) {
      activateClickableSession = sharedPreferences.getBool(
        StorageKey.activateClickableSession.key,
      );
      showRestartInCourse = sharedPreferences.getBool(
        StorageKey.showRestartInCourse.key,
      );
      templateCourse = sharedPreferences.getString(
        StorageKey.templateAndCourse.key,
      );
      statusBarDisabled = sharedPreferences.getBool(
        StorageKey.debugStatusBarDisabled.key,
      );
    }

    return PreferencesState(
      trackingPermission: trackingPermission,
      crashReportingPermission: crashReportingPermission,
      notificationTime: notificationTime,
      notificationEnabled: notificationEnabled,
      sessionLockNotificationEnabled: sessionLockNotificationEnabled,
      activateClickableSession: activateClickableSession,
      showRestartInCourse: showRestartInCourse,
      templateCourse: templateCourse,
      statusBarDisabled: statusBarDisabled,
    );
  }
}

@Riverpod(keepAlive: true, dependencies: [storages])
class Preferences extends _$Preferences {
  static final log = Logger("Settings");

  @override
  PreferencesState build() {
    final sharedPreferences = ref.read(storagesProvider).shared;
    return PreferencesState.fromSharedPreferences(sharedPreferences);
  }

  void setTrackingPermission(bool allowed) {
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setBool(StorageKey.allowTracking.key, allowed);
    state = state.copyWith(trackingPermission: allowed);
  }

  void setCrashReportingPermission(bool allowed) {
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setBool(StorageKey.allowCrashReporting.key, allowed);
    state = state.copyWith(crashReportingPermission: allowed);
  }

  void setNotificationTime(TimeOfDay time) {
    final sharedPreferences = ref.watch(storagesProvider).shared;
    sharedPreferences.setInt(StorageKey.notificationTimeHour.key, time.hour);
    sharedPreferences.setInt(
      StorageKey.notificationTimeMinute.key,
      time.minute,
    );
    state = state.copyWith(notificationTime: time);
  }

  void setNotificationPermission(bool permission) {
    final sharedPreferences = ref.watch(storagesProvider).shared;
    sharedPreferences.setBool(StorageKey.notificationEnabled.key, permission);
    state = state.copyWith(notificationEnabled: permission);
  }

  void setSessionLockNotificationPermission(bool permission) {
    final sharedPreferences = ref.watch(storagesProvider).shared;
    sharedPreferences.setBool(
      StorageKey.sessionLockNotificationEnabled.key,
      permission,
    );
    state = state.copyWith(sessionLockNotificationEnabled: permission);
  }

  void setActivateClickableSession(bool activate) {
    if (!kDebugMode) {
      log.warning(
        "Tried to set activateClickableSession in non-debug mode. This should not happen.",
      );
      return;
    }
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setBool(
      StorageKey.activateClickableSession.key,
      activate,
    );
    state = state.copyWith(activateClickableSession: activate);
  }

  void setShowRestartInCourse(bool show) {
    if (!kDebugMode) {
      log.warning(
        "Tried to set activateClickableSession in non-debug mode. This should not happen.",
      );
      return;
    }
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setBool(StorageKey.showRestartInCourse.key, show);
    state = state.copyWith(showRestartInCourse: show);
  }

  void setTemplateCourse(String templateCourse) {
    if (!kDebugMode) {
      log.warning(
        "Tried to set activateClickableSession in non-debug mode. This should not happen.",
      );
      return;
    }
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setString(
      StorageKey.templateAndCourse.key,
      templateCourse,
    );
    state = state.copyWith(templateCourse: templateCourse);
  }

  void setStatusBarDisabled(bool disabled) {
    if (!kDebugMode) {
      log.warning(
        "Tried to set activateClickableSession in non-debug mode. This should not happen.",
      );
      return;
    }
    final sharedPreferences = ref.read(storagesProvider).shared;
    sharedPreferences.setBool(StorageKey.debugStatusBarDisabled.key, disabled);
    state = state.copyWith(statusBarDisabled: disabled);
  }
}
