import 'package:amsl_app/models/hikari/transcript/transcript_record.dart'
    as hikari_transcript;
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

  factory TranscriptRecord.fromHikari(
    hikari_transcript.TranscriptRecord record,
  ) => TranscriptRecord(
    id: record.id,
    title: record.title,
    description: record.description,
    unlocked: record.unlocked,
    requirements: record.requirements
        .map(TranscriptRequirement.fromHikari)
        .toList(),
  );
}

@freezed
abstract class TranscriptRequirement with _$TranscriptRequirement {
  const factory TranscriptRequirement({
    required String label,
    required bool met,
  }) = _TranscriptRequirement;

  factory TranscriptRequirement.fromHikari(
    hikari_transcript.TranscriptRequirement requirement,
  ) => TranscriptRequirement(label: requirement.label, met: requirement.met);
}
