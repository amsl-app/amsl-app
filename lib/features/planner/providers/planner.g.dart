// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlannerProvider)
final plannerProviderProvider = PlannerProviderProvider._();

final class PlannerProviderProvider
    extends $AsyncNotifierProvider<PlannerProvider, List<PlannerEntry>> {
  PlannerProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plannerProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          PlannerProviderProvider.$allTransitiveDependencies0,
          PlannerProviderProvider.$allTransitiveDependencies1,
          PlannerProviderProvider.$allTransitiveDependencies2,
          PlannerProviderProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$plannerProviderHash();

  @$internal
  @override
  PlannerProvider create() => PlannerProvider();
}

String _$plannerProviderHash() => r'a41222a6f1cb2ad5b29c6073a7bd6c621b436a91';

abstract class _$PlannerProvider extends $AsyncNotifier<List<PlannerEntry>> {
  FutureOr<List<PlannerEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PlannerEntry>>, List<PlannerEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PlannerEntry>>, List<PlannerEntry>>,
              AsyncValue<List<PlannerEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
