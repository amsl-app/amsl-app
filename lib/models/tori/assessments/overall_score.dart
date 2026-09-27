/// The overall self-assessment score, averaged across all scales and
/// tracked over time.
class OverallScore {
  final double latest;
  final double? previous;
  final double? reference;
  final Map<DateTime, double> values;

  OverallScore({
    required this.latest,
    required this.values,
    this.previous,
    this.reference,
  });
}
