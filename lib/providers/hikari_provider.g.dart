// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hikari_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HikariPod)
final hikariPodProvider = HikariPodProvider._();

final class HikariPodProvider extends $NotifierProvider<HikariPod, Hikari> {
  HikariPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hikariPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[loginProvider, asyncLoginProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HikariPodProvider.$allTransitiveDependencies0,
          HikariPodProvider.$allTransitiveDependencies1,
          HikariPodProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = loginProvider;
  static final $allTransitiveDependencies1 =
      LoginProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      LoginProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$hikariPodHash();

  @$internal
  @override
  HikariPod create() => HikariPod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Hikari value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Hikari>(value),
    );
  }
}

String _$hikariPodHash() => r'dd0336162fd7647cc68e34264b72b9bdb7d1688d';

abstract class _$HikariPod extends $Notifier<Hikari> {
  Hikari build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Hikari, Hikari>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Hikari, Hikari>,
              Hikari,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
