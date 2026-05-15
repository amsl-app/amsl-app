import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/legal/ai_warning.dart';
import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/quiz/providers/quiz.dart';
import 'package:amsl_app/features/quiz/providers/quiz_score.dart';
import 'package:amsl_app/features/quiz/widgets/session_card.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/models/hikari/quiz/quiz.dart' as hikari_quiz;
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/models/tori/quiz/quiz.dart';
import 'package:amsl_app/models/tori/quiz/score.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleQuizScreen extends HookConsumerWidget {
  final String moduleID;
  const ModuleQuizScreen({super.key, required this.moduleID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final module = ref
        .watch(moduleConfigurationProviderProvider)
        .requireValue
        .quizzableModules
        .firstWhere((element) => element.module.id == moduleID)
        .module;

    return ref
        .watch(
          quizScoreProviderProvider.selectAsync(
            (data) => data.where((score) => score.moduleId == module.id),
          ),
        )
        .build(
          context,
          builder: (context, scores) {
            return ModuleQuizScreenInner(module: module, scores: scores ?? []);
          },
          loadingBuilder: (context) {
            return SkeletonLoadingScreen(
              backgroundColor: theme.colorScheme.tertiaryContainer,
              goBackAllowed: true,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return SkeletonLoadingScreen(
              backgroundColor: theme.colorScheme.tertiaryContainer,
              goBackAllowed: true,
            );
          },
        );
  }
}

class ModuleQuizScreenInner extends StatefulHookConsumerWidget {
  ModuleQuizScreenInner({super.key, required this.module, required this.scores})
    : quizzableSessions = module.sessions.values
          .where((session) => session.quizzable)
          .toList();

  final Module module;
  final Iterable<Score> scores;

  final List<Session> quizzableSessions;

  @override
  ConsumerState<ModuleQuizScreenInner> createState() =>
      _ModuleQuizScreenInnerState();
}

class _ModuleQuizScreenInnerState extends ConsumerState<ModuleQuizScreenInner> {
  // All sessions that are unlocked and quizzable

  late List<String> selected = widget.quizzableSessions
      .where((session) => session.unlocked)
      .map((session) => session.id)
      .toList();

  String? highlighted;
  Quiz? lastOpenQuiz;

  void selectSession(Session session) {
    setState(() {
      if (selected.contains(session.id)) {
        selected.remove(session.id);
      } else {
        selected.add(session.id);
      }
    });
  }

  void highlightSession(Session session) {
    setState(() {
      if (highlighted == session.id) {
        highlighted = null;
      } else {
        highlighted = session.id;
      }
    });
  }

  @override
  void initState() {
    ref.listenManual(
      quizProviderProvider.selectAsync((data) {
        return data.firstWhereOrNull(
          (quiz) =>
              quiz.moduleId == widget.module.id &&
              quiz.status == hikari_quiz.QuizStatus.open,
        );
      }),
      (prev, next) {
        next.then((data) {
          if (mounted && data != null) {
            setState(() {
              lastOpenQuiz = data;
            });
          }
        });
      },
      fireImmediately: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final module = widget.module;
    final scores = widget.scores;
    final sharedPreferences = ref.watch(storagesProvider).shared;

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${module.title}  - Quiz",
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
        leading: IconButton(
          onPressed: () {
            context.goNamed("quiz");
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onTertiaryContainer,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Schau dir die Statistiken an oder wähle die Einheiten aus, um ein Quiz zu erstellen.',
                style: textTheme.bodyMedium,
              ),
              Gap(16),
              Wrap(
                spacing: 4,
                runSpacing: 8,
                direction: Axis.horizontal,
                children: [
                  RoundedCornerButton(
                    mainAxisSize: MainAxisSize.min,
                    borderColor: theme.colorScheme.primary,
                    label:
                        "Quizfragen für ${selected.length} Einheiten erstellen",
                    onTap: selected.isNotEmpty
                        ? () async {
                            try {
                              if (await checkApproval(
                                context,
                                sharedPreferences,
                                key: StorageKey.acceptOpenAIQuiz.key,
                                bottomBar: true,
                              )) {
                                final quiz = await ref
                                    .read(quizProviderProvider.notifier)
                                    .startQuiz(widget.module.id, selected);
                                if (context.mounted) {
                                  context.goNamed(
                                    "quiz_session",
                                    pathParameters: {
                                      "moduleID": widget.module.id.toString(),
                                      "quizID": quiz.id.toString(),
                                    },
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                showException(context, e);
                              }
                            }
                          }
                        : null,
                  ),
                  if (lastOpenQuiz != null)
                    RoundedCornerButton(
                      mainAxisSize: MainAxisSize.min,
                      borderColor: theme.colorScheme.primary,
                      buttonColor: Colors.white,
                      labelColor: theme.colorScheme.primary,
                      label: "Letztes Quiz fortsetzen",
                      onTap: () async {
                        if (await checkApproval(
                              context,
                              sharedPreferences,
                              key: StorageKey.acceptOpenAIQuiz.key,
                              bottomBar: true,
                            ) &&
                            context.mounted) {
                          context.goNamed(
                            "quiz_session",
                            pathParameters: {
                              "moduleID": widget.module.id,
                              "quizID": lastOpenQuiz!.id,
                            },
                          );
                        }
                      },
                    ),
                ],
              ),
              Gap(16),
              ...widget.quizzableSessions.map(
                (session) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: QuizzableSessionCard(
                    session: session,
                    scores: scores.where(
                      (score) => score.sessionId == session.id,
                    ),
                    selected: selected.contains(session.id),
                    highlighted: highlighted == session.id,
                    onHighlight: () => highlightSession(session),
                    onSelect: () => selectSession(session),
                  ),
                ),
              ),
              Gap(8),
              Gap(getBottomBarHeight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
