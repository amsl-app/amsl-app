import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants.dart';
import '../../../providers/user_provider.dart';
import '../../settings/settings_text_field.dart';

class ProfileSettings extends StatefulHookConsumerWidget {
  const ProfileSettings({super.key});

  @override
  ConsumerState<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preferences = ref.watch(preferencesProvider);
    final user = ref.watch(userPodProvider);

    final prefNotifier = ref.read(preferencesProvider.notifier);
    final userNotifier = ref.read(userPodProvider.notifier);

    final trackingPermission = preferences.trackingPermission;
    final crashReportingPermission = preferences.crashReportingPermission;

    void changeTrackingPermission(bool value) {
      prefNotifier.setTrackingPermission(value);
      showMessage(
        context,
        label: value
            ? "Du hast das Sammeln von Nutzungsdaten erlaubt."
            : "Du hast das Sammeln von Nutzungsdaten nicht mehr erlaubt.",
      );
    }

    void changeCrashReportingPermission(bool value) {
      prefNotifier.setCrashReportingPermission(value);
      showMessage(
        context,
        label: value
            ? "Du hast das Sammeln von Fehlermeldungen erlaubt."
            : "Du hast das Sammeln von Fehlermeldungen nicht mehr erlaubt.",
      );
    }

    return user.build(
      context,
      builder: (context, user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              showMessage(
                context,
                label:
                    "Es gab ein Problem beim Laden deiner Daten. Bitte versuche es später erneut.",
                error: true,
              );
              context.goNamed("home");
            }
          });
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            Scaffold(
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
                          "Profileinstellungen",
                          style: TextStyle(color: theme.colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: theme.colorScheme.surface,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsTextField(
                      label: "Dein Name",
                      initialValue: user.name ?? "",
                      onEditingComplete: (value) async {
                        FocusScope.of(context).unfocus();
                        userNotifier
                            .patchUser(name: value)
                            .handle(
                              context,
                              onData: (data) {
                                showMessage(
                                  context,
                                  label: "Der Name wurde erfolgreich geändert!",
                                );
                              },
                            );
                      },
                    ),
                    const Gap(20),
                    FutureBuilder(
                      future: ref.watch(variantPodProvider.future),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => changeTrackingPermission(
                                  !trackingPermission,
                                ),

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: trackingPermission,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onChanged: (_) =>
                                          changeTrackingPermission(
                                            !trackingPermission,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        TrackingConstants.analyticsLabel,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => changeCrashReportingPermission(
                                  !crashReportingPermission,
                                ),

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: crashReportingPermission,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onChanged: (_) =>
                                          changeCrashReportingPermission(
                                            !crashReportingPermission,
                                          ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        TrackingConstants.crashReportingLabel,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Gap(getBottomBarPadding(context)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
