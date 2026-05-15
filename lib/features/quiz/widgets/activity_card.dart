import 'package:amsl_app/features/legal/ai_warning.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/models/hikari/quiz/quiz.dart' show QuizStatus;
import 'package:amsl_app/models/tori/quiz/quiz.dart';
import 'package:amsl_app/widgets/text/moment_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizActivityCard extends StatefulHookConsumerWidget {
  const QuizActivityCard({super.key, required this.quiz, required this.module});

  final Quiz quiz;
  final Module module;

  @override
  ConsumerState<QuizActivityCard> createState() => _QuizActivityCardState();
}

class _QuizActivityCardState extends ConsumerState<QuizActivityCard> {
  @override
  Widget build(BuildContext context) {
    const br = BorderRadius.all(Radius.circular(16));
    final theme = Theme.of(context);
    final sharedPreferences = ref.watch(storagesProvider).shared;

    return ClipRRect(
      borderRadius: br,
      child: Opacity(
        opacity: widget.quiz.status == QuizStatus.open ? 1.0 : 0.5,
        child: Material(
          type: MaterialType.card,
          child: Ink(
            color: Colors.white,
            child: InkWell(
              borderRadius: br,
              onTap: widget.quiz.status == QuizStatus.open
                  ? () async {
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
                            "quizID": widget.quiz.id,
                          },
                        );
                      }
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            widget.module.title,
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.quiz.status == QuizStatus.open)
                          Text(
                            "Aktiv",
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                    Gap(8),
                    MomentText(
                      date: widget.quiz.createdAt,
                      maxLines: 1,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
