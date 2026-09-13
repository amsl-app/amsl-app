import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/models/hikari/transcript/transcript_record.dart';
import 'package:logging/logging.dart';

class HikariTranscriptApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariTranscriptApi');

  const HikariTranscriptApi(this.hikari);

  Future<List<TranscriptRecord>> getTranscriptRecords() => hikari.get(
    '/transcript-records',
    transform: (json) => [
      for (final r in json as List) TranscriptRecord.fromJson(r),
    ],
  );
}
