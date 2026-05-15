import 'package:amsl_app/models/hikari/journal/entry/journal_entry.dart';
import 'package:logging/logging.dart';

class CreatedEntity {
  static final log = Logger('CreatedEntity');

  final dynamic value;
  CreatedEntity(this.value);

  factory CreatedEntity.fromJson(Map<String, dynamic> json) {
    log.fine("CreatedEntity: $json");
    if (json.containsKey("JournalEntry")) {
      return CreatedEntity(JournalEntry.fromJson(json["JournalEntry"]));
    }
    return CreatedEntity(json);
  }

  Map<String, dynamic> toJson() {
    if (value is JournalEntry) {
      return (value as JournalEntry).toJson();
    }
    return value;
  }

  @override
  String toString() {
    return 'CreatedEntity{value: $value}';
  }
}
