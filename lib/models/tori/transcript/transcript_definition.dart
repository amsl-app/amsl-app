import 'package:amsl_app/models/tori/transcript/transcript_condition.dart';

/// A single catalog entry: what it's called, and the conditions that must
/// all be met (AND) for it to unlock. See `transcript_catalog.dart` for the
/// actual list — this is just the shape.
class TranscriptDefinition {
  final String id;
  final String title;
  final String description;
  final List<TranscriptCondition> conditions;

  const TranscriptDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.conditions,
  });
}
