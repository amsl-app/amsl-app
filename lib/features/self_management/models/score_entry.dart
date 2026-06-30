class ScoreEntry {
  final double value;
  final double min;
  final double max;
  final String assessmentTitle;
  final DateTime completed;

  const ScoreEntry({
    required this.value,
    required this.min,
    required this.max,
    required this.assessmentTitle,
    required this.completed,
  });
}
