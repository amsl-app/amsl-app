import 'dart:io' show Platform;

import 'package:amsl_app/features/upgrade_check/version_provider.dart';
import 'package:amsl_app/providers/package_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeCheck {
  static final log = Logger("UpgradeCheck");

  Future<void> checkVersion({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final updateData = ref.watch(updateDataProvider);

    if (updateData is NeedsUpdate) {
      log.info(
        "Required Version: ${updateData.minVersion}, App Version: ${updateData.appVersion}",
      );
      log.info("App version is outdated");
      if (context.mounted) {
        final packageInfo = ref.read(packageInfoProvider);
        _showUpgradeDialog(context: context, packageInfo: packageInfo);
      } else {
        log.info(
          "Not showing upgrade dialog because build context is no longer mounted",
        );
      }
    }
  }

  void _showUpgradeDialog({
    required BuildContext context,
    required PackageInfo packageInfo,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text("Neue Version Verfügbar"),
            content: const SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Deine App version wird nicht mehr unterstützt. Bitte update die app.",
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Updaten"),
                onPressed: () => onUpdate(context, packageInfo),
              ),
            ],
          ),
        );
      },
    );
  }

  Future onUpdate(BuildContext context, PackageInfo packageInfo) async {
    try {
      if (Platform.isAndroid) {
        launchUrl(
          Uri.parse(
            "https://play.google.com/store/apps/details?id=${packageInfo.packageName}",
          ),
          mode: LaunchMode.externalApplication,
        );
      } else if (Platform.isIOS) {
        launchUrl(
          Uri.parse("https://apps.apple.com/app/id/${packageInfo.packageName}"),
          mode: LaunchMode.externalApplication,
        );
      } else {
        launchUrl(Uri.parse("https://amsl.app"));
      }
    } catch (e) {
      log.warning("Starting app store failed", e);
    }
  }
}
