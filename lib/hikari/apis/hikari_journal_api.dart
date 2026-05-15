import 'dart:convert';

import 'package:amsl_app/hikari/apis/hikari_module_api.dart';
import 'package:amsl_app/models/hikari/journal/assistant/assistant_wordings.dart';
import 'package:amsl_app/models/hikari/journal/assistant/converstion_step.dart';
import 'package:logging/logging.dart';

import '../../models/hikari/journal/assistant/assistant_prompt.dart';
import '../../models/hikari/journal/entry/journal_content.dart';
import '../../models/hikari/journal/entry/journal_entry.dart';
import '../../models/hikari/journal/entry/journal_focus.dart';
import '../hikari_api.dart';

class HikariJournalApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariJournalApi');

  const HikariJournalApi(this.hikari);

  Future<List<JournalEntry>> getJournalEntries() async => hikari.get(
    "/journal/entries",
    transform: (json) {
      List<JournalEntry> journals = [];
      for (Map<String, dynamic> element in json) {
        journals.add(JournalEntry.fromJson(element));
      }
      return journals;
    },
  );

  Future<List<JournalContent>> getJournalContent({
    required String journalID,
  }) async => hikari.get(
    "/journal/entries/$journalID/content",
    transform: (json) {
      List<JournalContent> journalContent = [];
      for (Map<String, dynamic> element in json) {
        journalContent.add(JournalContent.fromJson(element));
      }
      return journalContent;
    },
  );

  Future<List<JournalFocus>> getJournalFocus({required String journalID}) =>
      hikari.get(
        "/journal/entries/$journalID/focus",
        transform: (json) => _mapFocus(json),
      );

  Future<List<JournalFocus>> getFocus() =>
      hikari.get("/journal/focus", transform: (json) => _mapFocus(json));

  Future<List<JournalFocus>> getUserFocus() =>
      hikari.get("/journal/focus/user", transform: (json) => _mapFocus(json));

  Future<JournalFocus> addUserFocus({
    required String iconString,
    required String name,
  }) => hikari.post(
    "/journal/focus/user",
    body: jsonEncode({'icon': iconString, 'name': name}),
    transform: (json) => JournalFocus.fromJson(json),
  );

  Future<void> editUserFocus({
    required String focusID,
    String? iconString,
    String? name,
    bool? hidden,
  }) => hikari.patch(
    "/journal/focus/user/$focusID",
    body: jsonEncode({'icon': ?iconString, 'name': ?name, 'hidden': ?hidden}),
  );

  Future<int> getJournalMood({required String journalID}) => hikari.get(
    "/journal/entries/$journalID/mood",
    transform: (json) => json as int,
  );

  Future<int> setJournalMood({required String journalID, required int mood}) =>
      hikari.put("/journal/entries/$journalID/mood", body: mood);

  List<JournalFocus> _mapFocus(List<dynamic> json) {
    List<JournalFocus> foci = [];
    for (Map<String, dynamic> element in json) {
      foci.add(JournalFocus.fromJson(element));
    }
    return foci;
  }

  Future<AssistantPrompt> getAssistantPrompt({
    required ConversationStep step,
  }) async {
    dynamic body = jsonEncode(step.toJson());
    log.fine(body);

    AssistantPrompt assistantPrompt = await hikari.post(
      "/journal/assistant/prompt",
      body: body,
      transform: (json) => AssistantPrompt.fromJson(json),
    );

    log.fine("Checkpoint: ${assistantPrompt.summary}");

    return assistantPrompt;
  }

  Future<AssistantWording> getWordingAlternatives({
    required List<ConversationStep> steps,
  }) async => hikari.post(
    "/journal/assistant/merge",
    body: jsonEncode(steps),
    transform: (json) => AssistantWording.fromJson(json),
  );

  Future<JournalFocus?> getJournalSummary() async {
    final body = jsonEncode({'time': formatDate(DateTime.now())});
    return await hikari.post(
      "/journal/assistant/summarize",
      body: body,
      transform: (json) {
        if (json['summary'] == null) {
          // If the user didn't create any entries yet, the API returns null (and 404)
          return null;
        }
        return JournalFocus.fromJson(json['summary']);
      },
      acceptedStatusCodes: {200, 404},
    );
  }
}
