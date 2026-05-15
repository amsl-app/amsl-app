import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum MoodData {
  veryBad(icon: Icons.mood_bad, description: "Sehr schlecht"),
  bad(icon: Icons.sentiment_very_dissatisfied, description: "Schlecht"),
  neutral(icon: Icons.sentiment_neutral, description: "Neutral"),
  good(icon: Icons.sentiment_satisfied_alt, description: "Sehr Gut"),
  veryGood(icon: Icons.sentiment_very_satisfied, description: "Ausgezeichnet");

  const MoodData({required this.icon, required this.description});

  final IconData icon;
  final String description;
}

class Mood {
  final MoodData data;
  final double value;

  const Mood({required this.data, required this.value});
}

class Moods {
  static const List<MoodData> _dataList = [
    MoodData.veryBad,
    MoodData.bad,
    MoodData.neutral,
    MoodData.good,
    MoodData.veryGood,
  ];

  static List<Mood> list = _dataList
      .mapIndexed(
        (index, value) =>
            Mood(data: value, value: index / (_dataList.length - 1)),
      )
      .toList();

  static Mood get(double mood) {
    int index = (mood * (list.length - 1)).round().clamp(0, list.length - 1);

    return list[index];
  }
}
