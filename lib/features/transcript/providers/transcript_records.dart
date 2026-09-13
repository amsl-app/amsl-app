import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/tori/transcript/transcript_record.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_records.g.dart';

@Riverpod(dependencies: [HikariPod])
Future<List<TranscriptRecord>> transcriptRecords(Ref ref) async {
  final hikari = ref.watch(hikariPodProvider);
  try {
    final records = await hikari.transcriptApi.getTranscriptRecords();
    return records.map(TranscriptRecord.fromHikari).toList();
  } on HikariException catch (e) {
    throw e.copyWith(resolve: () => ref.invalidateSelf());
  }
}
