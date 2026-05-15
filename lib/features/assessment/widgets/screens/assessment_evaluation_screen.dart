import 'package:amsl_app/features/assessment/widgets/expandable_section_list.dart';
import 'package:amsl_app/features/modules/providers/module_assessment_set.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants.dart';
import '../../../../models/tori/assessments/assessment_session.dart';
import '../evaluation_group_chart.dart';

class AssessmentEvaluation extends HookConsumerWidget {
  const AssessmentEvaluation({super.key, required this.moduleID});

  final String moduleID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final module = ref.watch(moduleAssessmentSetProvider(moduleID));

    if (module == null) {
      showException(context, const FrontendEndException("Module not found"));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed("home");
      });
      return const Scaffold();
    }

    final List<ToriAssessmentSession> finishedAssessmentSessions = [];
    if (module.preAssessment.assessmentSession?.status ==
        hikari_assessment.AssessmentStatus.finished) {
      finishedAssessmentSessions.add(module.preAssessment.assessmentSession!);
    }
    if (module.postAssessment.assessmentSession?.status ==
        hikari_assessment.AssessmentStatus.finished) {
      finishedAssessmentSessions.add(module.postAssessment.assessmentSession!);
    }
    return _build(context, ref, finishedAssessmentSessions);
  }

  Widget _build(
    BuildContext context,
    WidgetRef ref,
    List<ToriAssessmentSession> finishedAssessmentSessions,
  ) {
    finishedAssessmentSessions.sort(
      (a, b) => b.completed!.compareTo(a.completed!),
    );
    final theme = Theme.of(context);

    return Scaffold(
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
                  "Evaluation",
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: (finishedAssessmentSessions.isEmpty)
          ? Center(
              child: Text(
                "Kein Selbstest zum auswerten",
                style: theme.textTheme.titleLarge,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: ExpandableSectionList(
                  children: List.generate(finishedAssessmentSessions.length, (
                    index,
                  ) {
                    ToriAssessmentSession session =
                        finishedAssessmentSessions[index];
                    return ExpandableSection(
                      label:
                          "Selbsttest vom ${kNewDateFormat.format(session.completed!)}",
                      child: SingleSessionEvaluation(session: session),
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
