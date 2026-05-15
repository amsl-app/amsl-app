import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_content.freezed.dart';
part 'journal_content.g.dart';

@freezed
abstract class JournalContent with _$JournalContent {
  factory JournalContent({
    String? content,
    String? title,
    @JsonKey(name: 'created_at') required DateTime created,
    @JsonKey(name: 'updated_at') required DateTime updated,
    required String id,
    @JsonKey(name: 'journal_entry_id') required String journalEntryId,
  }) = _JournalContent;

  factory JournalContent.fromJson(Map<String, dynamic> json) =>
      _$JournalContentFromJson(json);
}
