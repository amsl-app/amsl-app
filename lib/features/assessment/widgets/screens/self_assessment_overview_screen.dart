import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/assessment/providers/assessments.dart';
import 'package:amsl_app/features/assessment/widgets/overall_score_chart.dart';
import 'package:amsl_app/features/assessment/widgets/scale_trend_card_list.dart';
import 'package:amsl_app/features/assessment/widgets/subassessment_picker_sheet.dart';
import 'package:amsl_app/models/tori/assessments/assessment.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelfAssessmentOverviewScreen extends ConsumerWidget {
  const SelfAssessmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncConfig = ref.watch(assessmentPodProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: theme.colorScheme.tertiaryContainer,
        title: Text(
          "Lernstrategien Assessment",
          style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
        ),
      ),
      body: asyncConfig.build(
        context,
        builder: (context, config) => SelfAssessmentContent(
          assessments: config?.shownAssessments.toList() ?? const [],
        ),
      ),
    );
  }
}

class SelfAssessmentContent extends StatelessWidget {
  final List<Assessment> assessments;

  const SelfAssessmentContent({super.key, required this.assessments});

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
            "Mit diesem Tool kannst du deine Lernstrategie Skills überprüfen."
            "Starte einen Assessment und sehe, was du schon gut kannst, welche Aspekte noch "
            "Raum für Verbesserung haben und wie sich dein Score über die Zeit "
            "entwickelt.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          const Gap(20),
          const OverallScoreChart(),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: RoundedCornerButton(
              label: "Selbsttest starten",
              buttonColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.onPrimary,
              onTap: () => context.pushNamed(
                'self_assessment_run',
                extra: assessments
                    .map((assessment) => assessment.assessmentId)
                    .toList(),
              ),
            ),
          ),
          Center(
            child: SecondaryButton(
              label: "Einen Teil auswählen",
              onTap: () => showSubAssessmentPickerSheet(context, assessments),
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
