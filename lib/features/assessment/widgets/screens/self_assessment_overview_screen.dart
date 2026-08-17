import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/assessment/providers/assessments.dart';
import 'package:amsl_app/features/assessment/widgets/overall_score_chart.dart';
import 'package:amsl_app/features/assessment/widgets/scale_trend_card_list.dart';
import 'package:amsl_app/features/assessment/widgets/subassessment_picker_sheet.dart';
import 'package:amsl_app/models/tori/assessments/assessment.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/buttons/secondary_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> startSelfAssessment(
  BuildContext context,
  List<String> assessmentIds,
) async {
  context.pushNamed('self_assessment_run', extra: assessmentIds);
}

class SelfAssessmentOverviewScreen extends ConsumerWidget {
  const SelfAssessmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncAssessments = ref.watch(assessmentPodProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: theme.colorScheme.tertiaryContainer,
        title: Text(
          "Selbst- & Lernmanagement",
          style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
        ),
      ),
      body: asyncAssessments.build(
        context,
        builder: (context, assessments) => SelfAssessmentContent(
          assessments: assessments?.values.toList() ?? const [],
        ),
      ),
    );
  }
}

class SelfAssessmentContent extends StatelessWidget {
  final List<Assessment> assessments;

  const SelfAssessmentContent({super.key, required this.assessments});

  Future<void> _openSinglePartPicker(BuildContext context) async {
    await showAmslBottomSheet(
      context: context,
      bottomBar: true,
      onClose: () => context.pop(),
      child: SubassessmentPickerSheet(
        assessments: assessments,
        onSelect: (assessment) {
          context.pop();
          startSelfAssessment(context, [assessment.assessmentId]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (assessments.isEmpty) {
      return Center(
        child: Text(
          "Keine Selbsttests verfügbar",
          style: theme.textTheme.titleMedium,
        ),
      );
    }

    final scales = [for (final assessment in assessments) ...assessment.scales];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mit diesem Tool kannst du deine Selbst- und Lernmanagement-Skills überprüfen. "
            "Starte einen Selbsttest und sehe, was du schon gut kannst, wo noch "
            "Raum für Verbesserung ist und wie sich dein Score über die Zeit "
            "entwickelt.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          const Gap(20),
          OverallScoreChart(scales: scales),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: RoundedCornerButton(
              label: "Selbsttest starten",
              buttonColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.onPrimary,
              onTap: () => startSelfAssessment(
                context,
                assessments
                    .map((assessment) => assessment.assessmentId)
                    .toList(),
              ),
            ),
          ),
          Center(
            child: SecondaryButton(
              label: "Einen Teil auswählen",
              onTap: () => _openSinglePartPicker(context),
            ),
          ),
          const Gap(32),
          ScaleTrendCardList(scales: scales),
          Gap(getBottomBarPadding(context)),
        ],
      ),
    );
  }
}
