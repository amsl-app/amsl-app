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

String _$plannerProviderHash() => r'3e015e59c1fd9f6fb43a47d7a03571a9cb6715b9';

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

@ProviderFor(IcalTokenProvider)
final icalTokenProviderProvider = IcalTokenProviderProvider._();

final class IcalTokenProviderProvider
    extends $AsyncNotifierProvider<IcalTokenProvider, String?> {
  IcalTokenProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'icalTokenProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          IcalTokenProviderProvider.$allTransitiveDependencies0,
          IcalTokenProviderProvider.$allTransitiveDependencies1,
          IcalTokenProviderProvider.$allTransitiveDependencies2,
          IcalTokenProviderProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$icalTokenProviderHash();

  @$internal
  @override
  IcalTokenProvider create() => IcalTokenProvider();
}

String _$icalTokenProviderHash() => r'c51c9938f30ef9bb73427a2661920daeaa66b394';

abstract class _$IcalTokenProvider extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
