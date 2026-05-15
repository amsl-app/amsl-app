import 'dart:math';

import 'package:amsl_app/features/quiz/providers/quiz_score.dart';
import 'package:amsl_app/features/quiz/widgets/quiz_score.dart';
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizzableModuleCard extends HookConsumerWidget {
  const QuizzableModuleCard({super.key, required this.module});

  final Module module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const br = BorderRadius.all(Radius.circular(16));
    final theme = Theme.of(context);

    final aggregatedScoreAsync = ref.watch(
      quizScoreProviderProvider.selectAsync(
        (data) =>
            data
                .where((score) => score.moduleId == module.id)
                .map((e) => e.score)
                .fold<double>(0, (prev, element) => prev + element) /
            max(1, data.where((score) => score.moduleId == module.id).length),
      ),
    );

    return ClipRRect(
      borderRadius: br,
      child: Material(
        type: MaterialType.card,
        child: Ink(
          color: theme.colorScheme.tertiary,
          child: InkWell(
            borderRadius: br,
            onTap: () {
              context.goNamed(
                "quiz_module_detail",
                pathParameters: {"moduleID": module.id},
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    style: theme.textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    module.subtitle ?? module.description ?? "",
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8),
                  aggregatedScoreAsync.build(
                    context,
                    builder: (context, data) {
                      final score = data ?? 0.0;
                      return QuizScore(score: score);
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        LoadingText(color: theme.colorScheme.tertiary),
                    loadingBuilder: (context) =>
                        LoadingText(color: theme.colorScheme.tertiary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
