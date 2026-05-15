import 'package:amsl_app/features/journal/providers/journal.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/variants.dart';
import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../models/tori/journal/journal_entry.dart';
import '../../../../models/tori/modules/module_configuration.dart';
import '../../../../models/tori/modules/session.dart';
import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../../../../widgets/error/error_bar.dart';
import '../../../modules/providers/module_configuration.dart';

import '../../pdf/pdf_generator.dart';
import '../history/journal_list.dart';
import '../summary/reflection_summary_list.dart';

class ReflectionScreen extends StatefulHookConsumerWidget {
  const ReflectionScreen({super.key});

  @override
  ConsumerState<ReflectionScreen> createState() => _ReflectionState();
}

class _ReflectionState extends ConsumerState<ReflectionScreen> {
  static final log = Logger("ReflectionState");
  static const double horizontalPadding = 24;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final asyncJournal = ref.watch(journalProvider);
    final asyncModules = ref.watch(moduleConfigurationProviderProvider);
    final asyncVariant = ref.watch(variantPodProvider);

    final Widget widget = switch ((asyncModules, asyncJournal, asyncVariant)) {
      (
        AsyncData<ModuleConfiguration>(value: final mc),
        AsyncData<List<ToriJournalEntry>>(value: final journalEntries),
        AsyncData<Variant>(value: final variant),
      ) =>
        _buildSuccess(
          variant: variant,
          context: context,
          moduleConfiguration: mc,
          journals: journalEntries,
          theme: theme,
        ),
      // TODO handle error properly
      (AsyncError(:final error), _, _) ||
      (_, AsyncError(:final error), _) ||
      (_, _, AsyncError(:final error)) => _buildError(error),
      _ => SkeletonLoadingScreen(
        backgroundColor: theme.colorScheme.tertiaryContainer,
        goBackAllowed: true,
      ),
    };
    return widget;
  }

  Widget _buildSuccess({
    required Variant variant,
    required BuildContext context,
    required ModuleConfiguration moduleConfiguration,
    required List<ToriJournalEntry> journals,
    required ThemeData theme,
  }) {
    Session? runningJournalSession = moduleConfiguration.runningJournalSession;

    void onButtonPressed() {
      Session? directSession;

      directSession ??= runningJournalSession;

      if (directSession != null) {
        context.pushNamed(
          "chat",
          pathParameters: {
            "moduleID": directSession.module.target!.id,
            "sessionID": directSession.id,
          },
        );
      } else {
        context.goNamed("reflection_course");
      }
    }

    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);

    DateTime fourAgo = now.subtract(const Duration(days: 4));

    List<ToriJournalEntry> journalsLastFiveDays = [];

    for (var element in journals) {
      if (element.created.isAfter(fourAgo)) {
        journalsLastFiveDays.add(element);
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Lernjournal",
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.only(
                bottom: kBottomNavigationBarHeight,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth - horizontalPadding;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: HapticRefreshIndicator(
                      onRefresh: () async {
                        return reloadAll(ref, context);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Ein Lernjournal kann dir helfen, über dein Lernverhalten zu reflektieren. Mit der Zeit erlaubt es dir, effizienter und effektiver zu lernen.",
                                    style: theme.textTheme.bodySmall!,
                                  ),
                                ),
                                const Gap(8),
                                SvgPicture.asset(
                                  'assets/images/journal/blogging.svg',
                                  width: maxWidth * (2.3 / 5),
                                ),
                              ],
                            ),
                            const Gap(20.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Material(
                                color: theme.colorScheme.primary,
                                child: Ink(
                                  child: InkWell(
                                    onTap: () => onButtonPressed(),
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        widthFactor: 1,
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minWidth: 220,
                                          ),
                                          child: Text(
                                            getJournalLabel(
                                              runningJournalSession != null,
                                              variant,
                                            ),
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    journalsLastFiveDays.isEmpty
                                        ? "Keine Journaleinträge in den letzten 5 Tagen."
                                        : "Du hast an den markierten Tagen einen Journaleintrag erstellt.",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                                const Gap(20),
                                ReflectionSummaryList(
                                  journals: journalsLastFiveDays,
                                ),
                              ],
                            ),
                            const Gap(20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Deine Journaleinträge:",
                                  style: theme.textTheme.titleMedium,
                                ),
                                Visibility(
                                  visible: journals.isNotEmpty,
                                  child: IconButton(
                                    tooltip: "Alle Journaleinträge exportieren",
                                    onPressed: () =>
                                        PdfGenerator.exportMultiplePdfs(
                                          journals,
                                        ),
                                    icon: const Icon(Icons.ios_share),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20.0),
                            JournalList(journals: journals),
                            const Gap(80.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getJournalLabel(bool hasRunningSession, Variant variant) {
    if (hasRunningSession) return 'Journaleintrag fortsetzen';
    return 'Journaleintrag erstellen';
  }

  Widget _buildError(Object error) {
    log.warning("Error building reflection screen: $error");
    return AmslDialog(
      bottomBar: true,
      buttonBar: [
        RoundedCornerButton(
          label: "Erneut versuchen",
          onTap: () => reloadAll(ref, context),
        ),
      ],
    );
  }
}
