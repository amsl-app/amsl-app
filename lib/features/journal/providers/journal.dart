import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/hikari.dart';
import '../../../models/hikari/journal/entry/journal_content.dart'
    as hikari_content;
import '../../../models/hikari/journal/entry/journal_entry.dart'
    as hikari_entry;
import '../../../models/hikari/journal/entry/journal_focus.dart'
    as hikari_focus;
import '../../../models/tori/journal/journal_entry.dart';
import '../../../providers/hikari_provider.dart';

part 'journal.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod, VariantPod])
class Journal extends _$Journal {
  static final log = Logger("Journals");

  @override
  FutureOr<List<ToriJournalEntry>> build() {
    final hikari = ref.watch(hikariPodProvider);

    return _loadJournalsFromApi(hikari);
  }

  Future<List<ToriJournalEntry>> _loadJournalsFromApi(Hikari hikari) async {
    final variant = await ref.watch(variantPodProvider.future);
    if (!variant.journalEnabled) {
      log.info("Journals are not enabled for this variant");
      return [];
    }
    final List<ToriJournalEntry> journals = [];
    final List<hikari_entry.JournalEntry> hikariEntries = await hikari
        .journalApi
        .getJournalEntries();

    log.info("Loaded ${hikariEntries.length} journals");
    try {
      for (hikari_entry.JournalEntry e in hikariEntries) {
        final result = await Future.wait([
          hikari.journalApi.getJournalContent(journalID: e.id),
          hikari.journalApi.getJournalFocus(journalID: e.id),
        ]);

        journals.add(
          ToriJournalEntry.fromHikari(
            e,
            result[0] as List<hikari_content.JournalContent>,
            result[1] as List<hikari_focus.JournalFocus>,
          ),
        );
      }
      journals.sort((a, b) => b.created.compareTo(a.created));
    } on HikariException catch (e) {
      log.info("Failed to load journals: ${e.message}");
      throw e.copyWith(resolve: reloadJournals);
    }
    return journals;
  }

  Future<List<ToriJournalEntry>> reloadJournals() async {
    ref.invalidateSelf();
    return future;
  }
}
