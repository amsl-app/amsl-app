import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript_record.freezed.dart';
part 'transcript_record.g.dart';

@freezed
abstract class TranscriptRecord with _$TranscriptRecord {
  factory TranscriptRecord({
    required String id,
    required String title,
    required String description,
    required bool unlocked,
    required List<TranscriptRequirement> requirements,
  }) = _TranscriptRecord;

  factory TranscriptRecord.fromJson(Map<String, dynamic> json) =>
      _$TranscriptRecordFromJson(json);
}

@freezed
abstract class TranscriptRequirement with _$TranscriptRequirement {
  factory TranscriptRequirement({required String label, required bool met}) =
      _TranscriptRequirement;

  factory TranscriptRequirement.fromJson(Map<String, dynamic> json) =>
      _$TranscriptRequirementFromJson(json);
}
