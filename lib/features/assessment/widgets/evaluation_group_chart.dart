import 'package:amsl_app/models/tori/assessments/assessment_session.dart';
import 'package:amsl_app/models/tori/assessments/scale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SingleSessionEvaluation extends StatelessWidget {
  final ToriAssessmentSession session;

  const SingleSessionEvaluation({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(session.scales.length, (index) {
        Scale scale = session.scales[index];
        if (scale.value != null) {
          return EvaluationGroupChart(
            value: scale.value!,
            max: scale.max,
            min: scale.min,
            title: scale.title,
          );
        }
        return Container();
      }),
    );
  }
}

class EvaluationGroupChart extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;

  const EvaluationGroupChart({
    super.key,
    required this.title,
    required this.max,
    required this.min,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const double barHeight = 20;
    const double height = 25;
    const double indicatorWidth = 4;
    final theme = Theme.of(context);
    return Column(
      children: [
        Text("$title:", style: theme.textTheme.titleMedium),
        const Gap(10),
        LayoutBuilder(
          builder: (context, constraints) {
            double leftPadding =
                (constraints.maxWidth - indicatorWidth) /
                (max - min) *
                (value - min);
            return SizedBox(
              height: height,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: theme.colorScheme.tertiary,
                        height: barHeight,
                        width: constraints.maxWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: leftPadding),
                    child: Container(
                      height: height,
                      width: indicatorWidth,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Niedrig"), Text("Hoch")],
        ),
      ],
    );
  }
}
