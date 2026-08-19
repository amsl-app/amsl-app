import 'package:amsl_app/features/modules/providers/module_assessment_set.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../models/hikari/modules/session.dart' as hikari_session;
import '../../../../../models/hikari/planner/module_milestone.dart'
    as hikari_planner;
import '../../../../../models/tori/modules/session.dart';
import '../../../../../widgets/cached_image.dart';
import '../../../../constants.dart';
import '../../../../models/tori/modules/module.dart';
import '../../../../models/tori/modules/module_assessment.dart';
import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../../../../widgets/error/error_bar.dart';

import '../../../../../features/profile/providers/variant_provider.dart';
import '../session_list.dart';

class SessionSelectionScreen extends StatefulHookConsumerWidget {
  static final log = Logger("SessionSelectionScreenState");

  const SessionSelectionScreen({super.key, required this.moduleID});

  final String moduleID;

  @override
  ConsumerState<SessionSelectionScreen> createState() =>
      _SessionSelectionScreenState();
}

class _SessionSelectionScreenState
    extends ConsumerState<SessionSelectionScreen> {
  bool showPostAssessmentToDo = true;
  bool showEvaluationHint = false;
  bool hasAssessment = false;

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    sharedPreferences = ref.read(storagesProvider).shared;

    final ModuleAssessmentSet? module = ref.watch(
      moduleAssessmentSetProvider(widget.moduleID),
    );

    if (module == null) {
      showMessage(
        context,
        label: "Das Module konnte nicht geladen werden.",
        error: true,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pop();
      });
      return const SizedBox.shrink();
    } else {
      return _build(context, module);
    }
  }

  Widget _build(BuildContext context, ModuleAssessmentSet moduleAssessmentSet) {
    final baseTheme = Theme.of(context);
    final moduleTheme =
        moduleAssessmentSet.module.theme ?? baseTheme.moduleTheme;

    Map<Object, ThemeExtension<dynamic>> extensions =
        (Map<Object, ThemeExtension<dynamic>>.from(baseTheme.extensions)
          ..[moduleTheme.type] = moduleTheme);

    final theme = baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
        foregroundColor: moduleTheme.textColor,
      ),
      textTheme: baseTheme.textTheme.apply(
        bodyColor: moduleTheme.textColor,
        displayColor: moduleTheme.textColor,
      ),
      extensions: extensions.values,
    );

    final assessmentEnabled =
        ref.watch(variantPodProvider).value?.assessmentEnabled ?? true;

    showEvaluationHint =
        assessmentEnabled &&
        (sharedPreferences.getBool(StorageKey.showEvaluationHint.key) ?? false);

    hasAssessment =
        assessmentEnabled &&
        (moduleAssessmentSet.preAssessment.isDefined ||
            moduleAssessmentSet.postAssessment.isDefined);

    return Theme(
      data: theme,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(moduleAssessmentSet.module.title),
            ),
            backgroundColor: moduleTheme.color,
            actions: [
              if (hasAssessment && assessmentEnabled)
                IconButton(
                  icon: const Icon(Icons.analytics_outlined),
                  onPressed: () => context.goNamed(
                    "assessment_evaluation",
                    pathParameters: {"moduleID": moduleAssessmentSet.module.id},
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.flag),
                onPressed: () {
                  final hikari = ref.read(hikariPodProvider);

                  showAmslBottomSheet(
                    context: context,
                    bottomBar: true,
                    onClose: () => context.pop(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Meilensteine dieses Moduls",
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                        hikari.moduleApi
                            .getMilestones(moduleAssessmentSet.module.id)
                            .build(
                              context,
                              builder: (context, data) {
                                if (data == null || data.isEmpty) {
                                  return Text(
                                    "Keine Meilensteine vorhanden",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Gap(12),
                                    ...data.map(
                                      (milestone) =>
                                          _milestoneCard(context, milestone),
                                    ),
                                    const Gap(12),
                                    RoundedCornerButton(
                                      label: "Zum Planner hinzufügen",
                                      onTap: () async {
                                        try {
                                          final resp = await ref
                                              .read(
                                                milestonePodProvider.notifier,
                                              )
                                              .importMilestoneFromModule(
                                                moduleAssessmentSet.module.id,
                                              );
                                          final label = (resp.length == 1)
                                              ? "Meilenstein erfolgreich importiert"
                                              : "${resp.length} Meilensteine erfolgreich importiert";
                                          if (context.mounted) {
                                            context.pop();
                                            showMessage(context, label: label);
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            showException(context, e);
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                              loadingBuilder: (context) =>
                                  SkeletonLoadingWidget(rows: 1),
                              errorBuilder: (context, error, stackTrace) =>
                                  SkeletonLoadingWidget(rows: 1),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              _selectionList(context, moduleAssessmentSet.module),
              if (assessmentEnabled)
                _preAssessment(context, moduleAssessmentSet.preAssessment),
              if (assessmentEnabled)
                ..._postAssessment(context, moduleAssessmentSet),
              if (assessmentEnabled)
                _evaluation(context, moduleAssessmentSet.module),
            ],
          ),
        ),
      ),
    );
  }

  Widget _milestoneCard(
    BuildContext context,
    hikari_planner.ModuleMilestone milestone,
  ) {
    final theme = Theme.of(context);
    final imported = milestone.alreadyImported;

    return Opacity(
      opacity: imported ? 0.5 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          // color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.primary, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                imported ? Icons.check_circle : Icons.flag_outlined,
                color: theme.colorScheme.primary,
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      milestone.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (milestone.description != null)
                      Text(
                        milestone.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    Text(
                      kNewDateFormat.format(milestone.date),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selfLearningEntry(BuildContext context, Module module) {
    final theme = Theme.of(context);
    final selfLearning = (module.selfLearning)
        ? module.sessions["self-learning"]
        : null;

    if (selfLearning == null) {
      return Container();
    }

    return Column(
      children: [
        Text(
          "Nutze den Modus 'Freies Lernen', wenn du konkrete Fragen zu den Inhalten aller Einheiten hast. Hier kannst du direkt Fragen stellen, die dir die AMSL beantwortet.",
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.moduleTheme.descriptionColor,
          ),
        ),
        const Gap(12),
        RoundedCornerButton(
          buttonColor: theme.moduleTheme.containerColor,
          label: "Freies Lernen",
          icon: Icons.forum_outlined,
          onTap: () {
            context.pushNamed(
              "chat",
              pathParameters: {
                "moduleID": selfLearning.module.target!.id,
                "sessionID": selfLearning.id,
              },
            );
          },
        ),
        const Gap(24),
      ],
    );
  }

  Widget _quizEntry(BuildContext context, Module module) {
    final theme = Theme.of(context);
    final quiz = module.quizzable;

    if (!quiz) {
      return Container();
    }

    return Column(
      children: [
        Text(
          "Du glaubst, dass du die Inhalte der Einheiten gut verstanden hast? Teste hier dein Wissen mit dem Exam Coach!",
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.moduleTheme.descriptionColor,
          ),
        ),
        const Gap(12),
        RoundedCornerButton(
          buttonColor: theme.moduleTheme.containerColor,
          labelColor: theme.moduleTheme.descriptionColor,
          label: "Zum Exam Coach",
          icon: Icons.open_in_new_outlined,
          onTap: () => {
            context.goNamed(
              "quiz_module_detail",
              pathParameters: {"moduleID": module.id},
            ),
          },
        ),
        const Gap(24),
      ],
    );
  }

  Widget _selectionList(BuildContext context, Module module) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          decoration: BoxDecoration(color: theme.moduleTheme.color),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ..._header(context, constraints.maxWidth, module),
                SessionList(
                  module: module,
                  onChat: (session) {
                    context.pushNamed(
                      "chat",
                      pathParameters: {
                        "moduleID": session.module.target!.id,
                        "sessionID": session.id,
                      },
                    );
                  },
                ),
                Gap(getBottomBarPadding(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _preAssessment(
    BuildContext context,
    ModuleAssessmentSession preAssessment,
  ) {
    final theme = Theme.of(context);

    bool preAssessmentToDo =
        (preAssessment.isDefined &&
        (preAssessment.assessmentSession == null ||
            preAssessment.assessmentSession!.status !=
                hikari_assessment.AssessmentStatus.finished));

    return Visibility(
      visible: preAssessmentToDo,
      child: Stack(
        children: [
          Blur(blurColor: theme.moduleTheme.color, child: Container()),
          AmslDialog(
            bottomBar: true,
            buttonBar: [
              RoundedCornerButton(
                label: "Selbsttest starten",
                onTap: () {
                  context.goNamed(
                    "assessment",
                    pathParameters: {
                      'prePost': 'pre',
                      'moduleID': widget.moduleID,
                    },
                  );
                },
              ),
            ],
            content: "Nimm  am Selbsttest teil um das Modul zu starten!",
          ),
        ],
      ),
    );
  }

  List<Widget> _postAssessment(
    BuildContext context,
    ModuleAssessmentSet module,
  ) {
    final theme = Theme.of(context);
    final postAssessment = module.postAssessment;

    bool postAssessmentToDo =
        allSessionsDone(module.module) &&
        (postAssessment.isDefined &&
            (postAssessment.assessmentSession == null ||
                postAssessment.assessmentSession!.status !=
                    hikari_assessment.AssessmentStatus.finished));

    return [
      Visibility(
        visible: postAssessmentToDo && showPostAssessmentToDo,
        child: Stack(
          children: [
            Blur(blurColor: theme.moduleTheme.color, child: Container()),
            AmslDialog(
              onClose: () => setState(() {
                showPostAssessmentToDo = false;
              }),
              bottomBar: true,
              buttonBar: [
                RoundedCornerButton(
                  label: "Selbsttest starten",
                  onTap: () {
                    context.goNamed(
                      "assessment",
                      pathParameters: {
                        'prePost': 'post',
                        'moduleID': widget.moduleID,
                      },
                    );
                  },
                ),
              ],
              content: "Nimm  am Selbsttest teil um das Modul zu beenden!",
            ),
          ],
        ),
      ),
      Visibility(
        visible: postAssessmentToDo && !showPostAssessmentToDo,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  top: 90.0 - getBottomBarHeight(context),
                  left: 18.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(8 / 360),
                      child: InkWell(
                        onTap: () => setState(() {
                          showPostAssessmentToDo = true;
                        }),
                        child: SvgPicture.asset(
                          "assets/images/avatar_images/amsl_hello_shadow.svg",
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ];
  }

  Widget _evaluation(BuildContext context, Module module) {
    final theme = Theme.of(context);

    return Visibility(
      visible: showEvaluationHint,
      child: Stack(
        children: [
          Blur(blurColor: theme.moduleTheme.color, child: Container()),
          AmslDialog(
            onClose: () => setState(() {
              sharedPreferences.setBool(
                StorageKey.showEvaluationHint.key,
                false,
              );
            }),
            bottomBar: true,
            buttonBar: [
              RoundedCornerButton(
                label: "Zur Evaluation",
                onTap: () {
                  setState(() {
                    sharedPreferences.setBool(
                      StorageKey.showEvaluationHint.key,
                      false,
                    );
                  });
                  context.goNamed(
                    "assessment_evaluation",
                    pathParameters: {"moduleID": module.id},
                  );
                },
              ),
            ],
            content:
                "Du hast deinen ersten Selbsttest abgeschlossen. Du kannst über das Icon oben rechts auf die Auswertung zugreifen.",
          ),
        ],
      ),
    );
  }

  List<Widget> _header(BuildContext context, double maxWidth, Module module) {
    final theme = Theme.of(context);

    final double horizontalPadding = 24;
    final double availableWidth = maxWidth - horizontalPadding;

    if (module.selfLearning || module.quizzable) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _selfLearningEntry(context, module),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _quizEntry(context, module),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Du möchtest die Inhalte nochmal durcharbeiten oder hast die Vorlesung verpasst? Nutze diese Einheit, um die Inhalte im Tutorium-Stil mit der AMSL zu bearbeiten. Die AMSL leitet dich durch die Inhalte und hilft dir, diese zu verstehen.",
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.moduleTheme.descriptionColor,
            ),
          ),
        ),
        const Gap(12),
      ];
    }

    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: availableWidth * (3 / 5),
                child: Text(
                  module.description ?? "",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.moduleTheme.descriptionColor,
                  ),
                ),
              ),
            ),
            const Gap(8),
            module.banner != null
                ? CachedImage(
                    width: availableWidth * (2 / 5),
                    imageUrl: module.banner!,
                  )
                : Container(),
          ],
        ),
      ),
      const Gap(12),
    ];
  }

  bool allSessionsDone(Module module) {
    for (Session session in module.sessions.values) {
      if (session.status != hikari_session.SessionStatus.finished) {
        return false;
      }
    }
    return true;
  }
}

enum Hint { none, evaluation }
