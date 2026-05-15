import '../../hikari/journal/entry/journal_content.dart' as hikari_content;

class JournalContent {
  final String? content;
  final String? title;
  final DateTime created;
  final DateTime updated;
  final String id;

  JournalContent({
    required this.content,
    required this.created,
    required this.id,
    required this.title,
    required this.updated,
  });

  JournalContent.fromHikari(hikari_content.JournalContent content)
    : id = content.id,
      title = content.title,
      created = content.created,
      updated = content.updated,
      content = content.content;
}
