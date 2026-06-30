import 'package:amsl_app/features/modules/providers/module_assessment_set.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../models/hikari/modules/session.dart' as hikari_session;
import '../../../../../models/tori/modules/session.dart';
import '../../../../../widgets/cached_image.dart';
import '../../../../constants.dart';
import '../../../../models/tori/modules/module.dart';
import '../../../../models/tori/modules/module_assessment.dart';
import '../../../../widgets/buttons/rounded_corner_button.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../../../../widgets/error/error_bar.dart';

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

    showEvaluationHint =
        sharedPreferences.getBool(StorageKey.showEvaluationHint.key) ?? false;
    hasAssessment =
        moduleAssessmentSet.preAssessment.isDefined ||
        moduleAssessmentSet.postAssessment.isDefined;

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
            actions: const [],
          ),
          body: Stack(
            children: [
              _selectionList(context, moduleAssessmentSet.module),
              _preAssessment(context, moduleAssessmentSet.preAssessment),
              ..._postAssessment(context, moduleAssessmentSet),
              _evaluation(context, moduleAssessmentSet.module),
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
          "Du glaubst, dass du die Inhalte der Einheiten gut verstanden hast? Teste hier dein Wissen im Prüfungsquiz!",
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.moduleTheme.descriptionColor,
          ),
        ),
        const Gap(12),
        RoundedCornerButton(
          buttonColor: theme.moduleTheme.containerColor,
          labelColor: theme.moduleTheme.descriptionColor,
          label: "Zum Prüfungsquiz",
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
                label: "Zum Selbstmanagement",
                onTap: () {
                  setState(() {
                    sharedPreferences.setBool(
                      StorageKey.showEvaluationHint.key,
                      false,
                    );
                  });
                  context.goNamed("self_management");
                },
              ),
            ],
            content:
                "Du hast deinen ersten Selbsttest abgeschlossen. Deine Auswertung findest du im Selbstmanagement-Tool auf der Startseite.",
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
