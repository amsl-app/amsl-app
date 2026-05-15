// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryProvider)
final historyProviderProvider = HistoryProviderProvider._();

final class HistoryProviderProvider
    extends $AsyncNotifierProvider<HistoryProvider, List<HistoryEntry>> {
  HistoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          hikariPodProvider,
          assessmentSessionsProvider,
          moduleProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          HistoryProviderProvider.$allTransitiveDependencies0,
          HistoryProviderProvider.$allTransitiveDependencies1,
          HistoryProviderProvider.$allTransitiveDependencies2,
          HistoryProviderProvider.$allTransitiveDependencies3,
          HistoryProviderProvider.$allTransitiveDependencies4,
          HistoryProviderProvider.$allTransitiveDependencies5,
          HistoryProviderProvider.$allTransitiveDependencies6,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = assessmentSessionsProvider;
  static final $allTransitiveDependencies5 = moduleProvider;
  static final $allTransitiveDependencies6 =
      ModuleNotifierProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$historyProviderHash();

  @$internal
  @override
  HistoryProvider create() => HistoryProvider();
}

String _$historyProviderHash() => r'832da6b09c81120307a1f373589a4d1fa124457e';

abstract class _$HistoryProvider extends $AsyncNotifier<List<HistoryEntry>> {
  FutureOr<List<HistoryEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryEntry>>, List<HistoryEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HistoryEntry>>, List<HistoryEntry>>,
              AsyncValue<List<HistoryEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
