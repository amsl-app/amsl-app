import 'package:amsl_app/app.dart';
import 'package:amsl_app/features/notifications/notification.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/flavors.dart';
import 'package:amsl_app/logging.dart';
import 'package:amsl_app/providers/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void common_main() async {
  final log = Logger("main");
  setupLogging();

  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.initNotifications();
  await notificationService.removeBadge();

  // Disable landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  log.info("Loading preferences");
  final sharedPreferences = await SharedPreferences.getInstance();
  final secureStorage = FlutterSecureStorage();
  log.info("Loading Package info");
  final packageInfo = await PackageInfo.fromPlatform();
  Moment.setGlobalLocalization(MomentLocalizations.de());

  if (F.debugEnabled) {
    if (sharedPreferences.getBool(StorageKey.debugStatusBarDisabled.key) ??
        false) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  final Storages preferences = Storages(
    shared: sharedPreferences,
    secure: secureStorage,
  );

  runApp(
    ProviderScope(
      overrides: [
        storagesProvider.overrideWithValue(preferences),
        packageInfoProvider.overrideWithValue(packageInfo),
      ],
      observers: [ProviderLogger()],
      child: const App(),
    ),
  );
}
