import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/flavors.dart';
import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../settings/settings_button.dart';

class Settings extends HookConsumerWidget {
  static final log = Logger("Settings");

  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncVariant = ref.watch(variantPodProvider).asData?.value;
    final journalEnabled = asyncVariant?.journalEnabled ?? false;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: HapticRefreshIndicator(
        onRefresh: () => ref.read(userPodProvider.notifier).reloadUser(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsButton(
                label: "Profileinstellungen",
                icon: Icons.account_circle_outlined,
                onTap: () {
                  context.goNamed('profile_settings');
                },
              ),
              const Gap(16),
              SettingsButton(
                label: "Benachrichtigungen",
                icon: Icons.notifications,
                onTap: () {
                  context.goNamed('notification_settings');
                },
              ),
              if (journalEnabled) const Gap(16),
              if (journalEnabled)
                SettingsButton(
                  label: "Deine Fokusse",
                  icon: Icons.insert_emoticon,
                  onTap: () {
                    context.goNamed('focus_settings');
                  },
                ),
              if (F.debugEnabled) const Gap(16),
              if (F.debugEnabled)
                SettingsButton(
                  label: "Debug Settings",
                  icon: Icons.bug_report_outlined,
                  onTap: () {
                    context.goNamed('debug_settings');
                  },
                ),
              const Gap(32),
              SettingsButton(
                label: "Über uns",
                icon: Icons.menu_book_outlined,
                onTap: () {
                  context.goNamed("about_us");
                },
              ),
              const Gap(16),
              SettingsButton(
                label: "Datenschutzrichtlinien",
                icon: Icons.policy_outlined,
                onTap: () async {
                  await launchUrl(
                    Uri.parse("https://amsl.app/app/datenschutz"),
                  );
                },
              ),
              const Gap(16),
              SettingsButton(
                label: "Einwilligungserklärung",
                icon: Icons.error_outline,
                onTap: () async {
                  await launchUrl(
                    Uri.parse("https://amsl.app/app/einwilligung"),
                  );
                },
              ),
              const Gap(16),
              SettingsButton(
                label: "Über diese App",
                icon: Icons.info_outline,
                onTap: () {
                  context.goNamed("app_info");
                },
              ),
              const Gap(32),
              SettingsButton(
                buttonColor: theme.colorScheme.primary,
                labelColor: theme.colorScheme.onPrimary,
                label: "Abmelden",
                icon: Icons.logout,
                onTap: () {
                  showAmslBottomSheet(
                    bottomBar: true,
                    context: context,
                    content: "Möchtest du dich wirklich abmelden?",
                    buttonBar: [
                      RoundedCornerButton(
                        label: "Abmelden",
                        onTap: () {
                          context.replaceNamed("start");
                          ref.read(asyncLoginProvider.notifier).logout();
                        },
                      ),
                      RoundedCornerButton(
                        buttonColor: theme.colorScheme.surfaceContainer,
                        labelColor: theme.colorScheme.primary,
                        label: "Abbrechen",
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                    onClose: () => Navigator.pop(context),
                  );
                },
              ),
              Gap(2 * getBottomBarHeight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
