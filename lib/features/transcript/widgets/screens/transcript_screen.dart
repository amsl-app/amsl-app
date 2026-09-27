import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/features/transcript/providers/transcript_records.dart';
import 'package:amsl_app/features/transcript/widgets/transcript_record_tile.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRecords = ref.watch(transcriptRecordsProvider);
    final userId = ref.watch(userPodProvider).value?.id;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Leistungsnachweise",
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: asyncRecords.build(
          context,
          builder: (context, records) {
            if (records == null || records.isEmpty) {
              return Center(
                child: Text(
                  "Du hast keine Leistungsnachweise. Füge neue Module hinzu, um Leistungsnachweise zu freizuschalten.",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.separated(
              itemCount: records.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) =>
                  TranscriptRecordTile(record: records[index], userId: userId),
            );
          },
        ),
      ),
    );
  }
}
