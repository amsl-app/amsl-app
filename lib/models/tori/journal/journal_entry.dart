import '../../hikari/journal/entry/journal_content.dart' as hikari_content;
import '../../hikari/journal/entry/journal_entry.dart' as hikari_entry;
import '../../hikari/journal/entry/journal_focus.dart' as hikari_focus;
import 'journal_content.dart';
import 'journal_focus.dart';

class ToriJournalEntry {
  final String id;
  final DateTime created;
  final DateTime updated;
  final String? title;
  final double? mood;
  final List<JournalContent> content;
  final List<JournalFocus> focus;

  ToriJournalEntry({
    required this.id,
    required this.created,
    required this.content,
    required this.focus,
    required this.title,
    required this.updated,
    required this.mood,
  });

  ToriJournalEntry.fromHikari(
    hikari_entry.JournalEntry entry,
    List<hikari_content.JournalContent> content,
    List<hikari_focus.JournalFocus> focus,
  ) : id = entry.id,
      created = entry.created,
      updated = entry.updated,
      title = entry.title,
      mood = entry.mood,
      focus = focus.map((e) => JournalFocus.fromHikari(e)).toList(),
      content = content.map((e) => JournalContent.fromHikari(e)).toList();
}
