import 'dart:math' as math;

import 'package:amsl_app/features/journal/widgets/history/journal_list_tile.dart';
import 'package:amsl_app/features/journal/widgets/history/single_journal.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/widgets/dialogs/closeable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JournalHistoryPopover extends StatelessWidget {
  final List<ToriJournalEntry> journals;

  const JournalHistoryPopover({super.key, required this.journals});

  static const Color lightYellow = Color.fromRGBO(245, 231, 202, 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CloseableDialog(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(math.max(0, journals.length * 2 - 1), (
              index,
            ) {
              if (index.isOdd) {
                return const Gap(8);
              }

              final itemIndex = index ~/ 2;
              ToriJournalEntry journal = journals[itemIndex];

              return JournalListTileBox(
                journal: journal,
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => CloseableDialog(
                    backgroundColor: theme.colorScheme.tertiaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleJournal(journal: journal),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
