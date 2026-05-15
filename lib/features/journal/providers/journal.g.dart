// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Journal)
final journalProvider = JournalProvider._();

final class JournalProvider
    extends $AsyncNotifierProvider<Journal, List<ToriJournalEntry>> {
  JournalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider, variantPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          JournalProvider.$allTransitiveDependencies0,
          JournalProvider.$allTransitiveDependencies1,
          JournalProvider.$allTransitiveDependencies2,
          JournalProvider.$allTransitiveDependencies3,
          JournalProvider.$allTransitiveDependencies4,
          JournalProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = variantPodProvider;
  static final $allTransitiveDependencies5 =
      VariantPodProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$journalHash();

  @$internal
  @override
  Journal create() => Journal();
}

String _$journalHash() => r'ce1defdd26356825eeba599fbe95566e60867196';

abstract class _$Journal extends $AsyncNotifier<List<ToriJournalEntry>> {
  FutureOr<List<ToriJournalEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ToriJournalEntry>>, List<ToriJournalEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ToriJournalEntry>>,
                List<ToriJournalEntry>
              >,
              AsyncValue<List<ToriJournalEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
