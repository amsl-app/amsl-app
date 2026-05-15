import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/quiz/providers/quiz.dart';
import 'package:amsl_app/features/quiz/widgets/activity_card.dart';
import 'package:amsl_app/features/quiz/widgets/module_card.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final moduleConfiguration = ref.watch(moduleConfigurationProviderProvider);
    final quizzes = ref.watch(quizProviderProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Quiz",
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: HapticRefreshIndicator(
          onRefresh: () =>
              ref.read(quizProviderProvider.notifier).reloadQuizzes(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hier kannst du zu den Modulen, Quizze erstellen um dich auf die Klausur vorzubereiten. Das Module muss die Funktion "Quiz erstellen" unterstützen.',
                  style: textTheme.bodyMedium,
                ),
                Gap(8),
                Text(
                  textAlign: TextAlign.left,
                  'Deine Module:',
                  style: textTheme.bodyMedium,
                ),
                Gap(8),
                moduleConfiguration.build(
                  context,
                  builder: (context, data) {
                    final quizzableModules = data?.quizzableModules ?? [];

                    if (quizzableModules.isEmpty) {
                      return Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Es sind keine Module verfügbar. Füge Module hinzu, die Quizze unterstützen, um diese Funktion zu nutzen.',
                          style: textTheme.bodyMedium,
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...quizzableModules.map(
                          (module) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: QuizzableModuleCard(module: module.module),
                          ),
                        ),
                        Gap(8),
                        Text(
                          textAlign: TextAlign.left,
                          'Deine Aktivitäten:',
                          style: textTheme.bodyMedium,
                        ),
                        Gap(8),
                        quizzes.build(
                          context,
                          builder: (context, data) {
                            final quizzes = (data ?? []).sorted(
                              (a, b) => b.createdAt.compareTo(a.createdAt),
                            );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (quizzes.isEmpty)
                                  Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Du hast noch keine Quizze gemacht. Starte ein Quiz, um deine Kenntnisse zu testen!',
                                      style: textTheme.bodyMedium,
                                    ),
                                  )
                                else
                                  ...quizzes.take(20).map((quiz) {
                                    final module = quizzableModules
                                        .firstWhereOrNull(
                                          (element) =>
                                              element.module.id ==
                                              quiz.moduleId,
                                        )
                                        ?.module;

                                    if (module == null) {
                                      return const SizedBox.shrink();
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: QuizActivityCard(
                                        quiz: quiz,
                                        module: module,
                                      ),
                                    );
                                  }),
                              ],
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const SkeletonLoadingWidget(),
                          loadingBuilder: (context) =>
                              const SkeletonLoadingWidget(),
                        ),
                      ],
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      SkeletonLoadingWidget(color: theme.colorScheme.tertiary),
                  loadingBuilder: (context) =>
                      SkeletonLoadingWidget(color: theme.colorScheme.tertiary),
                ),
                Gap(getBottomBarHeight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
