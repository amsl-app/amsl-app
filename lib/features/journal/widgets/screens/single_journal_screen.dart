import 'package:amsl_app/features/journal/pdf/pdf_generator.dart';
import 'package:amsl_app/features/journal/widgets/history/single_journal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../models/tori/journal/journal_entry.dart';
import '../../providers/journal.dart';

class SingleJournalScreen extends HookConsumerWidget {
  const SingleJournalScreen({super.key, required this.journalID});

  final String journalID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ToriJournalEntry journal = ref.watch(
      journalProvider.select(
        (value) =>
            value.requireValue.firstWhere((element) => element.id == journalID),
      ),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: "Journaleintrag exportieren",
            icon: const Icon(Icons.ios_share),
            onPressed: () => PdfGenerator.exportSinglePdf(journal),
          ),
        ],
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  journal.title ?? journal.content.firstOrNull?.title ?? "",
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleJournal(journal: journal),
      ),
    );
  }
}
