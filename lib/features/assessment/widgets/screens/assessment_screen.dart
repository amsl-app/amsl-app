import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/assessment/providers/assessment_sessions.dart';
import 'package:amsl_app/features/assessment/widgets/answer_field.dart';
import 'package:amsl_app/features/assessment/widgets/yes_or_no.dart';
import 'package:amsl_app/features/modules/providers/module_assessment_set.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    show AssessmentType;
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/tori/assessments/assessment_session.dart';
import '../../../../models/tori/assessments/question.dart';
import '../../../../widgets/buttons/rounded_button.dart';
import '../../../../widgets/error/error_bar.dart';
import '../choice.dart';
import '../linear_numbered_box_scale.dart';
import 'assessment_flow.dart';

class AssessmentScreen extends StatefulHookConsumerWidget {
  final AssessmentFlow flow;

  const AssessmentScreen({super.key, required this.flow});

  @override
  ConsumerState<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends ConsumerState<AssessmentScreen> {
  static final log = Logger("AssessmentScreenState");

  List<int> notAnswered = [];
  bool started = false;
  bool loading = false;
  int selfAssessmentIndex = 0;
  ToriAssessmentSession? assessmentSession;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    switch (widget.flow) {
      case ModuleAssessmentFlow flow:
        return _buildModuleFlow(context, flow);
      case SelfAssessmentFlow flow:
        return _buildSelfAssessmentFlow(context, flow);
    }
  }

  Widget _buildModuleFlow(BuildContext context, ModuleAssessmentFlow flow) {
    final module = ref.watch(moduleAssessmentSetProvider(flow.moduleID));

    if (module == null) {
      showException(context, const FrontendEndException("Module not found"));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed("home");
      });
      return const Scaffold();
    }

    switch (flow.prePost) {
      case AssessmentType.pre:
        assessmentSession = module.preAssessment.assessmentSession;
        break;
      case AssessmentType.post:
        assessmentSession = module.postAssessment.assessmentSession;
        break;
    }

    if (assessmentSession != null) {
      return Stack(
        children: [
          _build(context, assessmentSession!),
          if (loading) const SkeletonLoadingScreen(goBackAllowed: true),
        ],
      );
    }

    if (!started) {
      Future.delayed(Duration.zero, () async {
        if (context.mounted) {
          ref
              .read(assessmentSessionsProvider.notifier)
              .startModuleAssessment(flow.moduleID, flow.prePost)
              .handle(context);
        }
        started = true;
      });
    }

    return SkeletonLoadingScreen(goBackAllowed: true);
  }

  Widget _buildSelfAssessmentFlow(
    BuildContext context,
    SelfAssessmentFlow flow,
  ) {
    if (assessmentSession != null) {
      return Stack(
        children: [
          _build(context, assessmentSession!),
          if (loading) const SkeletonLoadingScreen(goBackAllowed: true),
        ],
      );
    }

    if (!started) {
      started = true;
      Future.delayed(Duration.zero, () async {
        if (context.mounted) {
          ref
              .read(assessmentSessionsProvider.notifier)
              .startAssessment(flow.assessmentIds[selfAssessmentIndex])
              .handle(
                context,
                onData: (session) {
                  if (mounted) {
                    setState(() {
                      assessmentSession = session;
                    });
                  }
                },
              );
        }
      });
    }

    return const SkeletonLoadingScreen(goBackAllowed: true);
  }

  void close(BuildContext context) {
    switch (widget.flow) {
      case ModuleAssessmentFlow(:final moduleID):
        context.goNamed("module", pathParameters: {"moduleID": moduleID});
        if (assessmentSession != null) {
          ref
              .read(assessmentSessionsProvider.notifier)
              .reloadSingleAssessmentSession(
                assessmentId: assessmentSession!.assessmentId,
                sessionID: assessmentSession!.sessionId,
              );
        }
      case SelfAssessmentFlow():
        context.goNamed("self_assessment");
    }
  }

  void submit(BuildContext context) {
    unHighlight(assessmentSession!);
    if (allAnswered(assessmentSession!)) {
      setState(() {
        loading = true;
      });
      if (mounted) {
        ref
            .read(assessmentSessionsProvider.notifier)
            .submitAssessment(assessmentSession: assessmentSession!)
            .handle(
              context,
              onData: (_) => _onSubmitted(context),
              onError: (e, s) {
                setState(() {
                  loading = false;
                });
                final Object exception;
                if (e is HikariException) {
                  exception = e.copyWith(resolve: () => submit(context));
                } else {
                  exception = e;
                }
                if (mounted) {
                  showException(
                    context,
                    exception,
                    functions: [("Verwerfen", () => close(context))],
                  );
                }
              },
            );
      }
    } else {
      showMessage(context, label: "Beantworte erst alle Fragen");
      highlight(assessmentSession!);
      itemScrollController.scrollTo(
        index: notAnswered[0],
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void _onSubmitted(BuildContext context) {
    switch (widget.flow) {
      case ModuleAssessmentFlow():
        SharedPreferences sharedPreferences = ref
            .read(storagesProvider)
            .shared;
        if (!(sharedPreferences.getBool(StorageKey.firstAssessmentDone.key) ??
            false)) {
          sharedPreferences.setBool(StorageKey.showEvaluationHint.key, true);
          sharedPreferences.setBool(StorageKey.firstAssessmentDone.key, true);
        }
        close(context);
      case SelfAssessmentFlow(:final assessmentIds):
        if (selfAssessmentIndex + 1 < assessmentIds.length) {
          setState(() {
            selfAssessmentIndex += 1;
            assessmentSession = null;
            started = false;
            loading = false;
            notAnswered = [];
          });
        } else {
          setState(() {
            loading = false;
          });
          if (context.mounted) {
            showMessage(context, label: "Selbsttest abgeschlossen");
            close(context);
          }
        }
    }
  }

  Future setQuestionValue(Question question, dynamic value) async {
    log.info("Setting value of ${question.id} to $value");
    setState(() {
      question.answer = value;
    });
  }

  Widget _build(BuildContext context, ToriAssessmentSession assessmentSession) {
    final theme = Theme.of(context);

    Widget buildQuestion(BuildContext context, Question question, int index) {
      final theme = Theme.of(context);
      Color labelColor = (notAnswered.contains(index))
          ? theme.colorScheme.onError
          : theme.colorScheme.primary;

      switch (question) {
        case LikertScaleQuestion(
          :final hintMax,
          :final hintMin,
          :final max,
          :final min,
          :final answer,
          :final title,
          :final id,
        ):
          return LinearNumberedBoxScale(
            leftLabel: hintMin ?? "sehr niedrig",
            rightLabel: hintMax ?? "sehr hoch",
            min: min,
            max: max,
            onChange: (value) async => await setQuestionValue(question, value),
            label: title,
            value: answer,
            labelColor: labelColor,
            key: ValueKey(id),
          );
        case TextFieldQuestion(
          :final placeholder,
          :final answer,
          :final title,
          :final id,
        ):
          return AnswerField(
            hintText: placeholder,
            value: answer,
            multiLine: false,
            label: title,
            onChange: (value) async => await setQuestionValue(question, value),
            labelColor: labelColor,
            key: ValueKey(id),
          );
        case TextAreaQuestion(
          :final placeholder,
          :final answer,
          :final title,
          :final id,
        ):
          return AnswerField(
            hintText: placeholder,
            value: answer,
            multiLine: true,
            label: title,
            onChange: (value) async => await setQuestionValue(question, value),
            labelColor: labelColor,
            key: ValueKey(id),
          );
        case SelectQuestion(
          :final yes,
          :final no,
          :final answer,
          :final title,
          :final id,
        ):
          return YesOrNo(
            value: answer,
            trueLabel: yes ?? "Ja",
            falseLabel: no ?? "Nein",
            onChange: (value) async => await setQuestionValue(question, value),
            label: title,
            labelColor: labelColor,
            key: ValueKey(id),
          );
        case MultiChoiceQuestion(
          :final options,
          :final answer,
          :final title,
          :final id,
        ):
          return Choice(
            value: answer,
            options: options,
            label: title,
            onChange: (value) async => await setQuestionValue(question, value),
            labelColor: labelColor,
            multiChoice: true,
            key: ValueKey(id),
          );
        case SingleChoiceQuestion(:final answer, :final title, :final id):
          return Choice(
            value: answer,
            options: const [true],
            label: title,
            onChange: (value) async => await setQuestionValue(question, value),
            labelColor: labelColor,
            multiChoice: false,
            key: ValueKey(id),
          );
      }
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: ScrollablePositionedList.separated(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (_, index) {
          //TODO: better way
          if (index == assessmentSession.questions.length) {
            return Column(
              children: [
                RoundedButton(
                  buttonColor: allAnswered(assessmentSession)
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainer,
                  label: "Abschließen",
                  onTap: () => submit(context),
                ),
                Gap(getBottomBarPadding(context)),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: buildQuestion(
              context,
              assessmentSession.questions.values.elementAt(index),
              index,
            ),
          );
        },
        separatorBuilder: (_, _) => const Gap(20),
        itemCount: assessmentSession.questions.length + 1,
      ),
    );
  }

  bool allAnswered(ToriAssessmentSession assessment) {
    for (Question q in assessment.questions.values) {
      if (q.answer == null) return false;
    }
    return true;
  }

  void highlight(ToriAssessmentSession assessment) {
    for (int i = 0; i < assessment.questions.length; i++) {
      if (assessment.questions.values.elementAt(i).answer == null) {
        notAnswered.add(i);
      }
    }
    setState(() {});
  }

  void unHighlight(ToriAssessmentSession assessment) {
    setState(() {
      notAnswered.clear();
    });
  }
}
