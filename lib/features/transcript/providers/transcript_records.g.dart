// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_records.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Evaluates [transcriptCatalog] against currently-loaded app state. No
/// dedicated transcript-records network call — this reuses the app's
/// existing `keepAlive` providers, each of which fetches from Hikari on
/// its own first use and is cached afterward. Because this awaits all six
/// via `Future.wait`, any one of them failing surfaces as an error for
/// this whole screen (consistent with how `moduleProvider` itself already
/// composes multiple providers) rather than degrading per-condition.

@ProviderFor(transcriptRecords)
final transcriptRecordsProvider = TranscriptRecordsProvider._();

/// Evaluates [transcriptCatalog] against currently-loaded app state. No
/// dedicated transcript-records network call — this reuses the app's
/// existing `keepAlive` providers, each of which fetches from Hikari on
/// its own first use and is cached afterward. Because this awaits all six
/// via `Future.wait`, any one of them failing surfaces as an error for
/// this whole screen (consistent with how `moduleProvider` itself already
/// composes multiple providers) rather than degrading per-condition.

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
  /// Evaluates [transcriptCatalog] against currently-loaded app state. No
  /// dedicated transcript-records network call — this reuses the app's
  /// existing `keepAlive` providers, each of which fetches from Hikari on
  /// its own first use and is cached afterward. Because this awaits all six
  /// via `Future.wait`, any one of them failing surfaces as an error for
  /// this whole screen (consistent with how `moduleProvider` itself already
  /// composes multiple providers) rather than degrading per-condition.
  TranscriptRecordsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transcriptRecordsProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          moduleProvider,
          assessmentSessionsProvider,
          plannerPodProvider,
          goalPodProvider,
          milestonePodProvider,
          journalProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          TranscriptRecordsProvider.$allTransitiveDependencies0,
          TranscriptRecordsProvider.$allTransitiveDependencies1,
          TranscriptRecordsProvider.$allTransitiveDependencies2,
          TranscriptRecordsProvider.$allTransitiveDependencies3,
          TranscriptRecordsProvider.$allTransitiveDependencies4,
          TranscriptRecordsProvider.$allTransitiveDependencies5,
          TranscriptRecordsProvider.$allTransitiveDependencies6,
          TranscriptRecordsProvider.$allTransitiveDependencies7,
          TranscriptRecordsProvider.$allTransitiveDependencies8,
          TranscriptRecordsProvider.$allTransitiveDependencies9,
          TranscriptRecordsProvider.$allTransitiveDependencies10,
          TranscriptRecordsProvider.$allTransitiveDependencies11,
          TranscriptRecordsProvider.$allTransitiveDependencies12,
        },
      );

  static final $allTransitiveDependencies0 = moduleProvider;
  static final $allTransitiveDependencies1 =
      ModuleNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ModuleNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ModuleNotifierProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ModuleNotifierProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      ModuleNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      ModuleNotifierProvider.$allTransitiveDependencies5;
  static final $allTransitiveDependencies7 = plannerPodProvider;
  static final $allTransitiveDependencies8 = goalPodProvider;
  static final $allTransitiveDependencies9 = milestonePodProvider;
  static final $allTransitiveDependencies10 = journalProvider;
  static final $allTransitiveDependencies11 =
      JournalProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies12 =
      JournalProvider.$allTransitiveDependencies5;

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

String _$transcriptRecordsHash() => r'bb449196fb026e791b9994f767e50f1d090d4fe8';
