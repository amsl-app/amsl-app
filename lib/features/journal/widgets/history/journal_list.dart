import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import 'journal_list_tile.dart';

class JournalList extends StatelessWidget {
  final List<ToriJournalEntry> journals;

  const JournalList({super.key, required this.journals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (journals.isNotEmpty) {
      final journalTiles = journals
          .mapIndexedAndLast(
            (i, e, isLast) =>
                JournalListTile(journal: e, first: i == 0, last: isLast),
          )
          .toList(growable: false);

      return Column(children: journalTiles);
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            "Du hast noch keine Journaleinträge",
            style: theme.textTheme.titleLarge,
          ),
        ),
      );
    }
  }
}
