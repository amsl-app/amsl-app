import 'package:amsl_app/features/focus_timer/widgets/focus_timer.dart';
import 'package:amsl_app/features/journal/widgets/screens/reflection_screen.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/features/quiz/widgets/screens/quiz.dart';
import 'package:amsl_app/features/tools_common/widgets/tool_card.dart';
import 'package:amsl_app/themes/tool_card_theme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tools.g.dart';

@Riverpod(dependencies: [VariantPod])
Future<Map<String, Tool>> tools(Ref ref) async {
  final variant = await ref.watch(variantPodProvider.future);

  return {
    "focus_timer": Tool(
      id: "focus_timer",
      name: "Fokus Timer",
      widget: const FocusTimer(),
      decoration: Builder(
        builder: (BuildContext context) {
          final theme = Theme.of(context);

          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.toolCardTheme.decorationColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
    if (variant.journalEnabled)
      "reflection": Tool(
        id: "reflection",
        name: "Lernjournal",
        widget: const ReflectionScreen(),
        decoration: Builder(
          builder: (context) {
            final theme = Theme.of(context);

            return Align(
              alignment: Alignment.bottomRight,
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.toolCardTheme.decorationColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    "quiz": Tool(
      id: "quiz",
      name: "Quiz",
      widget: const QuizScreen(),
      decoration: Builder(
        builder: (BuildContext context) {
          final theme = Theme.of(context);
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Icon(
                    Icons.quiz,
                    size: 58,
                    color: theme.toolCardTheme.decorationColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  };
}
