import 'dart:math';

import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/quiz/providers/quiz.dart';
import 'package:amsl_app/features/quiz/widgets/feedback.dart' as quiz_feedback;
import 'package:amsl_app/features/quiz/widgets/question_answer_field.dart';
import 'package:amsl_app/models/tori/quiz/question.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/loading/loading_overlay.dart';
import 'package:amsl_app/widgets/loading/loading_screen.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String getFeedbackLoadingMessages() {
  List<String> messages = [
    'Deine Antwort bekommt gerade ihr Feedback-Makeover …',
    'Wir schauen uns an, wie genial du das gelöst hast …',
    'Die Punkte trudeln gleich bei dir ein – noch kurz warten!',
    'Deine Lösung wird mit den richtigen Kniffen verglichen …',
    'Fast da – dein Ergebnis wird schon gezählt …',
    'Mach dich bereit – dein Feedback kommt sofort!',
    'Deine Antwort wird gerade unter die Lupe genommen …',
    'Wir checken, wie viele Punkte du schon eingesackt hast …',
    'Die Bewertung läuft – gleich weißt du mehr!',
    'Wir gleichen deine Lösung mit dem Muster ab …',
    'Dein Feedback wird gerade zusammengestellt …',
    'Noch ein Augenblick – dein Ergebnis ist fast da!',
  ];
  return messages[Random().nextInt(messages.length)];
}

String getQuestionLoadingMessages() {
  List<String> messages = [
    'Wir tüfteln gerade an spannenden Fragen für dich …',
    'Die nächste Challenge wird schon zusammengebaut …',
    'Neue Quizfragen nehmen gerade Form an – gleich geht’s los!',
    'Wir mischen Wissen und Kreativität für deine nächste Aufgabe …',
    'Die Fragenmaschine läuft heiß – bitte kurz warten!',
    'Fast fertig – dein Quiz steht gleich bereit!',
    'Frischer Fragenstoff wird für dich angerührt …',
    'Wir basteln neue Quizfragen – gleich kannst du loslegen!',
    'Die Aufgabenwürze wird gerade gemischt …',
    'Deine nächste Herausforderung entsteht in diesem Moment …',
    'Die Fragen werden sortiert und verpackt …',
    'Alles klar – die nächste Runde Wissen ist fast fertig!',
  ];
  return messages[Random().nextInt(messages.length)];
}

class QuizSessionScreen extends StatefulHookConsumerWidget {
  final String moduleID;

  final String quizID;
  const QuizSessionScreen({
    super.key,
    required this.moduleID,
    required this.quizID,
  });

  @override
  ConsumerState<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends ConsumerState<QuizSessionScreen> {
  String? questionID;
  bool showFeedback = false;

  @override
  Widget build(BuildContext context) {
    final module = ref
        .watch(moduleConfigurationProviderProvider)
        .requireValue
        .quizzableModules
        .firstWhere((element) => element.module.id == widget.moduleID)
        .module;

    final theme = Theme.of(context);
    String answerText = "";

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Quiz zu '${module.title}'",
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              "quiz_module_detail",
              pathParameters: {"moduleID": module.id.toString()},
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onTertiaryContainer,
          ),
        ),
      ),
      body: questionID != null
          ? ref
                .watch(
                  quizProviderProvider.selectAsync((data) {
                    return data
                        .firstWhere((quiz) => quiz.id == widget.quizID)
                        .questions
                        .firstWhereOrNull(
                          (question) => question.id == questionID,
                        );
                  }),
                )
                .build(
                  context,
                  builder: (BuildContext context, question) {
                    HapticFeedback.heavyImpact();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: StatefulBuilder(
                        builder: (context, innerSetState) {
                          if (question?.evaluation != null && showFeedback) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showFeedbackDialog(context, question!);
                            });
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children:
                                (question !=
                                    null) // There is a very short moment where question can be null
                                ? [
                                    QuizQuestionAnswerField(
                                      question: question,
                                      onChanged: (value) => innerSetState(() {
                                        answerText = value;
                                      }),
                                    ),
                                    const Gap(16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.end,
                                        runAlignment: WrapAlignment.start,
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: (question.evaluation == null)
                                            ? [
                                                RoundedCornerButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: "Frage überspringen",
                                                  onTap: () {
                                                    skip(context);
                                                  },
                                                  labelColor:
                                                      theme.colorScheme.primary,
                                                  buttonColor: Colors.white,
                                                  borderColor:
                                                      theme.colorScheme.primary,
                                                ),
                                                RoundedCornerButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: "Antwort abschicken",
                                                  onTap:
                                                      answerText
                                                          .trim()
                                                          .isNotEmpty
                                                      ? () {
                                                          sendAnswer(
                                                            context,
                                                            question.id,
                                                            answerText.trim(),
                                                          );
                                                        }
                                                      : null,
                                                ),
                                              ]
                                            : [
                                                RoundedCornerButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: "Bewertung ansehen",
                                                  onTap: () async {
                                                    // innterSetState, since this widget triggers the dialog. This reduces reloading
                                                    innerSetState(
                                                      () => showFeedback = true,
                                                    );
                                                  },
                                                  labelColor:
                                                      theme.colorScheme.primary,
                                                  buttonColor: Colors.white,
                                                  borderColor:
                                                      theme.colorScheme.primary,
                                                ),
                                                RoundedCornerButton(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  label: "Nächste Frage",
                                                  onTap: () {
                                                    generateNewQuestion();
                                                  },
                                                ),
                                              ],
                                      ),
                                    ),
                                    Gap(getBottomBarPadding(context)),
                                  ]
                                : [],
                          );
                        },
                      ),
                    );
                  },
                  loadingBuilder: (BuildContext context) =>
                      SkeletonLoadingScreen(
                        backgroundColor: theme.colorScheme.tertiaryContainer,
                      ),
                )
          : AmslLoadingScreen(
              label: getQuestionLoadingMessages(),
              backgroundColor: theme.colorScheme.tertiaryContainer,
            ),
    );
  }

  void generateNewQuestion({
    bool? feedback,
    String? feedbackExplanation,
  }) async {
    if (questionID != null && feedback != null) {
      await ref
          .read(quizProviderProvider.notifier)
          .sendFeedback(
            widget.quizID,
            questionID!,
            feedback ? "good" : "bad",
            feedbackExplanation,
          );
    }
    setState(() {
      questionID = null;
    });

    if (mounted) {
      ref
          .read(quizProviderProvider.notifier)
          .getNextQuestion(widget.quizID)
          .handle(
            context,
            onData: (question) {
              setState(() {
                questionID = question.id;
              });
            },
          );
    }
  }

  @override
  void initState() {
    generateNewQuestion();
    super.initState();
  }

  Future<void> sendAnswer(
    BuildContext context,
    String questionID,
    String answer,
  ) async {
    debugPrint("Sending answer: $answer");
    await showDialog(
      context: context,
      builder: (context) {
        // No setState needed, since we the app is reloaded anyways due to the question update
        showFeedback = true;
        return ref
            .read(quizProviderProvider.notifier)
            .submitAnswer(widget.quizID, questionID, answer)
            .build(
              context,
              builder: (BuildContext context, question) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                return Container();
              },
              loadingBuilder: (BuildContext context) {
                return AmslLoadingOverlay(label: getFeedbackLoadingMessages());
              },
              errorBuilder: (context, e, s) {
                Navigator.of(context).pop();
                return Container();
              },
            );
      },
    );
  }

  void showFeedbackDialog(BuildContext context, Question question) async {
    // Prevent multiple triggers
    if (!showFeedback) {
      return;
    }
    showFeedback = false;
    final theme = Theme.of(context);

    quiz_feedback.Feedback userFeedback = quiz_feedback.Feedback();
    final aiSolution = solutionFromQuestion(question);

    showAmslBottomSheet(
      bottomBar: true,
      buttonBar: [
        RoundedCornerButton(
          mainAxisSize: MainAxisSize.min,
          label: "Nächste Frage",
          onTap: () {
            Navigator.pop(context);
            generateNewQuestion(
              feedback: userFeedback.feedback,
              feedbackExplanation: userFeedback.explanation,
            );
          },
        ),
      ],
      context: context,
      onClose: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bewertung: ${question.grade}/5",
            style: theme.textTheme.titleMedium,
          ),
          const Gap(16),
          Text(question.evaluation ?? ""),
          if (aiSolution != null) ...[
            const Gap(8),
            Text("Generierte AI Lösung:", style: theme.textTheme.titleSmall),
            Text(aiSolution),
          ],
          const Gap(16),
          quiz_feedback.QuizFeedback(
            onChange: (newFeedback) {
              userFeedback = newFeedback;
            },
          ),
        ],
      ),
    );
  }

  void skip(BuildContext context) {
    final theme = Theme.of(context);
    quiz_feedback.Feedback feedback = quiz_feedback.Feedback();

    showAmslBottomSheet(
      context: context,
      bottomBar: true,
      onClose: () => Navigator.pop(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Bist du sicher, dass du überspringen willst?",
            style: theme.textTheme.titleMedium,
          ),
          const Gap(8),
          quiz_feedback.QuizFeedback(
            onChange: (newFeedback) {
              feedback = newFeedback;
            },
          ),
        ],
      ),
      buttonBar: [
        RoundedCornerButton(
          label: "Überspringen",
          onTap: () async {
            if (questionID != null) {
              await ref
                  .read(quizProviderProvider.notifier)
                  .skipQuestion(widget.quizID, questionID!);
            }
            if (context.mounted) {
              Navigator.pop(context);
            }
            generateNewQuestion(
              feedback: feedback.feedback,
              feedbackExplanation: feedback.explanation,
            );
          },
        ),
      ],
    );
  }
}

String? solutionFromQuestion(Question question) {
  if (question.aiSolution != null) {
    return question.aiSolution;
  }
  final correct_options = (question.options ?? []).where(
    (o) => o.correct ?? false,
  );
  if (correct_options.isEmpty) {
    return null;
  }
  return correct_options.map((o) => o.option).join("\n");
}
