import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/tori/journal/journal_focus.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../hikari/exception.dart';

part 'focus.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class Focus extends _$Focus {
  static final log = Logger("Focus");

  @override
  Future<Map<String, JournalFocus>> build() async {
    final hikari = ref.watch(hikariPodProvider);

    final foci = await _loadFociFromApi(hikari);

    return foci;
  }

  Future<Map<String, JournalFocus>> _loadFociFromApi(Hikari hikari) async {
    final Map<String, JournalFocus> foci;
    try {
      final hikariFocus = await hikari.journalApi.getFocus();
      foci = {
        for (var focus in hikariFocus) focus.id: JournalFocus.fromHikari(focus),
      };
    } on HikariException catch (e) {
      log.info("Failed to load journalFocus: ${e.message}");
      throw e.copyWith(resolve: reloadFoci);
    }
    return foci;
  }

  Future<Map<String, JournalFocus>> reloadFoci() async {
    ref.invalidateSelf();
    return future;
  }

  Future<void> editFocus({
    required String focusID,
    bool? hidden,
    String? icon,
    String? name,
  }) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.journalApi.editUserFocus(
        focusID: focusID,
        iconString: icon,
        name: name,
        hidden: hidden,
      );
      await update((state) async {
        JournalFocus focus = state[focusID]!;
        state[focusID] = focus.copyWith(
          name: name ?? focus.name,
          iconString: icon ?? focus.iconString,
          hidden: hidden ?? focus.hidden,
        );
        return state;
      });
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () =>
            editFocus(focusID: focusID, hidden: hidden, icon: icon, name: name),
      );
    }
  }

  Future<String> addFocus({required String name, required String icon}) async {
    final hikari = ref.read(hikariPodProvider);
    final JournalFocus focus;

    try {
      final hikariFocus = await hikari.journalApi.addUserFocus(
        iconString: icon,
        name: name,
      );
      focus = JournalFocus.fromHikari(hikariFocus);
      update((state) async {
        state[focus.id] = focus;
        return state;
      });
      return focus.id;
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => addFocus(name: name, icon: icon),
      );
    }
  }
}
