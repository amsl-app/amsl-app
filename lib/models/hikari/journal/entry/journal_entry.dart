import 'package:json_annotation/json_annotation.dart';

part 'journal_entry.g.dart';

@JsonSerializable()
class JournalEntry {
  final String id;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "created_at")
  final DateTime created;
  @JsonKey(name: "updated_at")
  final DateTime updated;
  final String? title;
  final double? mood;

  JournalEntry({
    required this.id,
    required this.userId,
    required this.title,
    required this.mood,
    required this.created,
    required this.updated,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  @override
  String toString() {
    return 'JournalEntryModel{id: $id, userId: $userId, title: $title, created: $created, updated: $updated, mood: $mood}';
  }
}
