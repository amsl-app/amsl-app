// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_records.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transcriptRecords)
final transcriptRecordsProvider = TranscriptRecordsProvider._();

final class TranscriptRecordsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TranscriptRecord>>,
          List<TranscriptRecord>,
          FutureOr<List<TranscriptRecord>>
        >
    with
        $FutureModifier<List<TranscriptRecord>>,
        $FutureProvider<List<TranscriptRecord>> {
  TranscriptRecordsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transcriptRecordsProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          TranscriptRecordsProvider.$allTransitiveDependencies0,
          TranscriptRecordsProvider.$allTransitiveDependencies1,
          TranscriptRecordsProvider.$allTransitiveDependencies2,
          TranscriptRecordsProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$transcriptRecordsHash();

  @$internal
  @override
  $FutureProviderElement<List<TranscriptRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TranscriptRecord>> create(Ref ref) {
    return transcriptRecords(ref);
  }
}

String _$transcriptRecordsHash() => r'8122ca6bbddc01bf77c5ab24ed9d6b4103d4b98e';
