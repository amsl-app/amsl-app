import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../models/tori/modules/module_configuration.dart';
import '../../../../widgets/cached_image.dart';
import '../../../modules/providers/module_configuration.dart';
import '../../../modules/widgets/screens/session_selection_screen.dart';
import '../../../modules/widgets/session_list.dart';

class Journal extends StatefulHookConsumerWidget {
  const Journal({super.key});

  @override
  ConsumerState<Journal> createState() => _JournalState();
}

class _JournalState extends ConsumerState<Journal> {
  static const double horizontalPadding = 24;
  bool widgetBuilt = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ModuleConfiguration moduleConfiguration = ref
        .watch(moduleConfigurationProviderProvider)
        .requireValue;

    Module course = moduleConfiguration.journal!.module;

    Session? nextSession = moduleConfiguration.nextJournalSession;

    void doChat([Session? session]) async {
      session ??= nextSession;
      if (session == null) return;
      SessionSelectionScreen.log.info(
        "Selected session ${session.title} (${session.id})",
      );

      // Show chat
      if (context.mounted) {
        context.pushNamed(
          "chat",
          pathParameters: {"moduleID": course.id, "sessionID": session.id},
        );
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
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
                  course.title,
                  style: TextStyle(color: theme.colorScheme.surfaceContainer),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.secondary,
      ),
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth - horizontalPadding;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: maxWidth * (3 / 5),
                            child: Text(
                              course.description ?? "",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                        course.banner != null
                            ? CachedImage(
                                width: maxWidth * (2 / 5),
                                imageUrl: course.banner!,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const Gap(4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 2,
                    color: theme.colorScheme.surfaceContainer.withAlpha(50),
                  ),
                  const Gap(8),
                  SessionList(module: course, onChat: doChat),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
