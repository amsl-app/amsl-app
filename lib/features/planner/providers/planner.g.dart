// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlannerPod)
final plannerPodProvider = PlannerPodProvider._();

final class PlannerPodProvider
    extends $AsyncNotifierProvider<PlannerPod, List<PlannerEntry>> {
  PlannerPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plannerPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          PlannerPodProvider.$allTransitiveDependencies0,
          PlannerPodProvider.$allTransitiveDependencies1,
          PlannerPodProvider.$allTransitiveDependencies2,
          PlannerPodProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$plannerPodHash();

  @$internal
  @override
  PlannerPod create() => PlannerPod();
}

String _$plannerPodHash() => r'655e47818f5673eb5b26354a2b53dac9c0ad1b50';

abstract class _$PlannerPod extends $AsyncNotifier<List<PlannerEntry>> {
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

String _$icalTokenProviderHash() => r'2e2661451c56526cb441f7efb645b6fbb4d25d06';

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
