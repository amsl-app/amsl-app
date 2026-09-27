import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript_record.freezed.dart';

@freezed
abstract class TranscriptRecord with _$TranscriptRecord {
  const factory TranscriptRecord({
    required String id,
    required String title,
    required String description,
    required bool unlocked,
    required List<TranscriptRequirement> requirements,
  }) = _TranscriptRecord;
}

@freezed
abstract class TranscriptRequirement with _$TranscriptRequirement {
  const factory TranscriptRequirement({
    required String label,
    required bool met,
  }) = _TranscriptRequirement;
}
