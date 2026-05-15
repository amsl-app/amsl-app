import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuizScore extends StatelessWidget {
  final double score;

  const QuizScore({required this.score, super.key});

  int _levelFromScore() {
    return switch (score) {
      < 5 => 1,
      < 10 => 2,
      < 15 => 3,
      < 20 => 4,
      < 25 => 5,
      < 30 => 6,
      30 => 7,
      _ => 1,
    };
  }

  String _bloomText() {
    final level = _levelFromScore();
    return switch (level) {
      1 => "Du bist im Level 'Erinnern'.",
      2 =>
        "Du kannst die Fakten wiedergeben und befindest dich im Level 'Verstehen'.",
      3 => "Du verstehst die Konzepte. Jetzt sind wir im Level 'Anwenden'.",
      4 => "Du kannst Wissen anwenden. Zeit zum 'Analysieren'!",
      5 =>
        "Du kannst analysieren und bewerten. Willkommen im Level 'Bewerten'.",
      6 => "Wir sind im Level 'Erschaffen'.",
      7 =>
        'Perfekt! Du hast alle Bloom Level gemeistert! Bereite dich trotzdem kontinuierlich vor.',
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final level = _levelFromScore();
    final filledBars = (score % 5).toInt();
    final emptyBars = 5 - filledBars;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Bloom Level:'),
            const Gap(4),
            IconButton(
              icon: const Icon(Icons.info_outline),
              iconSize: 22,
              onPressed: () {
                showMessage(context, label: _bloomText());
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        // Level display and progress bars
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFA47432), width: 1),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Center(
                child: Text('$level / 7', style: const TextStyle(fontSize: 12)),
              ),
            ),
            const Gap(8),
            ...List.generate(
              filledBars,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFA47432),
                        width: 0.5,
                      ),
                      color: const Color(0xFFA47432),
                    ),
                  ),
                ),
              ),
            ),
            // Empty progress bars
            ...List.generate(
              emptyBars,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Container(
                    height: 12,
                    // width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFA47432),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
