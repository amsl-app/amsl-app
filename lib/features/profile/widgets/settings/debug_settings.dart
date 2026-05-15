import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../../../profile/providers/user_provider.dart';
import 'package:amsl_app/features/preferences/storages.dart';

class DropDownValue<T> {
  final T? value;

  const DropDownValue(this.value);

  @override
  bool operator ==(Object other) {
    if (other is DropDownValue<T>) {
      return other.value == value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;
}

class DebugSettings extends HookConsumerWidget {
  const DebugSettings({super.key});

  Widget _buildToggle({
    required ThemeData theme,
    required String label,
    required ValueNotifier<bool?> state,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        Switch(
          value: state.value ?? false,
          onChanged: (value) {
            state.value = value;
            onChanged(value);
          },
          activeTrackColor: theme.colorScheme.primary,
          activeThumbColor: theme.colorScheme.onPrimary,
          inactiveTrackColor: theme.colorScheme.onPrimary,
        ),
      ],
    );
  }

  Widget _buildStorageToggle({
    required ThemeData theme,
    required Storages storages,
    required String label,
    required ValueNotifier<bool?> state,
    required StorageKey storageKey,
  }) {
    return _buildToggle(
      theme: theme,
      label: label,
      state: state,
      onChanged: (value) {
        storages.shared.setBool(storageKey.key, value);
      },
    );
  }

  Widget _buildPreferenceToggle({
    required ThemeData theme,
    required String label,
    required ValueNotifier<bool?> state,
    required ValueChanged<bool> onChanged,
  }) {
    return _buildToggle(
      theme: theme,
      label: label,
      state: state,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesState = ref.read(preferencesProvider);
    final activate_clickable_session = useState<bool?>(
      preferencesState.activateClickableSession,
    );
    final show_restart_in_course = useState<bool?>(
      preferencesState.showRestartInCourse,
    );
    final status_bar_disabled = useState<bool?>(
      preferencesState.statusBarDisabled,
    );
    final accept_openai_chat = useState<bool?>(
      ref
          .read(storagesProvider)
          .shared
          .getBool(StorageKey.acceptOpenAIChat.key),
    );
    final dismissed_onboarding = useState<bool?>(
      ref
          .read(storagesProvider)
          .shared
          .getBool(StorageKey.dismissedOnBoarding.key),
    );
    final template_and_course = useState<DropDownValue<String>>(
      DropDownValue(preferencesState.templateCourse),
    );

    final theme = Theme.of(context);

    final preferencesNotifier = ref.read(preferencesProvider.notifier);
    final storages = ref.read(storagesProvider);
    final user = ref.watch(userPodProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Debug Settings",
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            showAmslBottomSheet(
              context: context,
              content:
                  "Es ist ein Neustart nötig, um die Änderungen zu übernehmen.",
              bottomBar: true,
              buttonBar: [
                RoundedCornerButton(
                  label: "Verstanden",
                  onTap: () {
                    Navigator.pop(context);
                    context.goNamed("profile");
                  },
                ),
              ],
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreferenceToggle(
                theme: theme,
                label: "Activate clickable session",
                state: activate_clickable_session,
                onChanged: preferencesNotifier.setActivateClickableSession,
              ),
              const Gap(20.0),
              _buildStorageToggle(
                theme: theme,
                storages: storages,
                label: "Accept OpenAI Chat",
                state: accept_openai_chat,
                storageKey: StorageKey.acceptOpenAIChat,
              ),
              Gap(20.0),
              _buildStorageToggle(
                theme: theme,
                storages: storages,
                label: "Dismissed onboarding",
                state: dismissed_onboarding,
                storageKey: StorageKey.dismissedOnBoarding,
              ),
              const Gap(20.0),
              _buildPreferenceToggle(
                theme: theme,
                label: "Show restart in course",
                state: show_restart_in_course,
                onChanged: preferencesNotifier.setShowRestartInCourse,
              ),
              const Gap(20.0),
              _buildPreferenceToggle(
                theme: theme,
                label: "Hide Statusbar",
                state: status_bar_disabled,
                onChanged: preferencesNotifier.setStatusBarDisabled,
              ),
              Gap(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Template & Course", style: theme.textTheme.titleMedium),
                  DropdownButton<DropDownValue<String>>(
                    value: template_and_course.value,
                    items: const [
                      DropdownMenuItem(
                        value: DropDownValue(null),
                        child: Text("System"),
                      ),
                      DropdownMenuItem(
                        value: DropDownValue("course"),
                        child: Text("Course"),
                      ),
                      DropdownMenuItem(
                        value: DropDownValue("template"),
                        child: Text("Template"),
                      ),
                    ],
                    onChanged: (DropDownValue<String>? value) {
                      if (value != null) {
                        template_and_course.value = value;
                        preferencesNotifier.setTemplateCourse(
                          value.value ?? "",
                        );
                      }
                    },
                  ),
                ],
              ),
              if (user != null) const Gap(20.0),
              if (user != null)
                Text("User Info", style: theme.textTheme.titleMedium),
              if (user != null) Text(user.toJson().toString()),
              const Gap(20.0),
              Text("Shared Preferences", style: theme.textTheme.titleMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ref
                    .watch(storagesProvider)
                    .shared
                    .getKeys()
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$e: ", style: theme.textTheme.titleSmall),
                          Text(
                            ref
                                .watch(storagesProvider)
                                .shared
                                .get(e)
                                .toString(),
                          ),
                          const Gap(5),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Gap(getBottomBarPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
