import 'package:amsl_app/features/quiz/widgets/quiz_score.dart';
import 'package:amsl_app/models/tori/quiz/score.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuizzableSessionCard extends StatelessWidget {
  QuizzableSessionCard({
    super.key,
    required this.session,
    required this.scores,
    required this.selected,
    required this.onSelect,
    required this.highlighted,
    required this.onHighlight,
  }) : _sessionScore = _calculateScore(scores);

  final Session session;
  final Iterable<Score> scores;
  final bool selected;
  final Function() onSelect;
  final bool highlighted;
  final Function() onHighlight;

  final double _sessionScore;

  double get sessionScore => _sessionScore;

  static double _calculateScore(Iterable<Score> scores) {
    if (scores.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (final score in scores) {
      total += score.score;
    }
    return total / scores.length;
  }

  @override
  Widget build(BuildContext context) {
    const br = BorderRadius.all(Radius.circular(16));
    final theme = Theme.of(context);

    return Opacity(
      opacity: session.unlocked ? 1.0 : 0.5,
      child: Row(
        children: [
          !session.unlocked
              ? Icon(Icons.lock, size: 24, color: theme.colorScheme.primary)
              : GestureDetector(
                  onTap: () => onSelect(),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2,
                      ),
                      color: selected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                    ),
                    child: selected
                        ? Icon(
                            size: 20,
                            Icons.check,
                            color: theme.colorScheme.tertiaryContainer,
                          )
                        : null,
                  ),
                ),
          const Gap(12),
          Expanded(
            child: ClipRRect(
              borderRadius: br,
              child: Material(
                type: MaterialType.card,
                child: Ink(
                  color: highlighted
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.tertiaryContainer,
                  child: InkWell(
                    borderRadius: br,
                    onTap: session.unlocked ? () => onHighlight() : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.title,
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            session.subtitle ?? session.description ?? "",
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(8),
                          highlighted
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(),
                                    ...session.topics
                                        .sorted((a, b) => a.compareTo(b))
                                        .map(
                                          (topic) => Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  topic,
                                                  style: theme
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                QuizScore(
                                                  score:
                                                      (scores
                                                                  .firstWhereOrNull(
                                                                    (s) =>
                                                                        s.topic ==
                                                                        topic,
                                                                  )
                                                                  ?.score ??
                                                              0.0)
                                                          .toDouble(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  ],
                                )
                              : QuizScore(score: sessionScore),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
