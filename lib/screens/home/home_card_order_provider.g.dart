// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_card_order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeCardOrder)
final homeCardOrderProvider = HomeCardOrderProvider._();

final class HomeCardOrderProvider
    extends $NotifierProvider<HomeCardOrder, List<HomeCardId>> {
  HomeCardOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeCardOrderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[storagesProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          HomeCardOrderProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = storagesProvider;

  @override
  String debugGetCreateSourceHash() => _$homeCardOrderHash();

  @$internal
  @override
  HomeCardOrder create() => HomeCardOrder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HomeCardId> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HomeCardId>>(value),
    );
  }
}

String _$homeCardOrderHash() => r'4614aa7ffdb101723eacc96dd7705c05bec10797';

abstract class _$HomeCardOrder extends $Notifier<List<HomeCardId>> {
  List<HomeCardId> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<HomeCardId>, List<HomeCardId>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<HomeCardId>, List<HomeCardId>>,
              List<HomeCardId>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
