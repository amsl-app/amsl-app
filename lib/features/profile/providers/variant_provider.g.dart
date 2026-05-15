// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VariantPod)
final variantPodProvider = VariantPodProvider._();

final class VariantPodProvider
    extends $AsyncNotifierProvider<VariantPod, Variant> {
  VariantPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'variantPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[userPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          VariantPodProvider.$allTransitiveDependencies0,
          VariantPodProvider.$allTransitiveDependencies1,
          VariantPodProvider.$allTransitiveDependencies2,
          VariantPodProvider.$allTransitiveDependencies3,
          VariantPodProvider.$allTransitiveDependencies4,
        },
      );

  static final $allTransitiveDependencies0 = userPodProvider;
  static final $allTransitiveDependencies1 =
      UserPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      UserPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      UserPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      UserPodProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$variantPodHash();

  @$internal
  @override
  VariantPod create() => VariantPod();
}

String _$variantPodHash() => r'55fc605e404ba4599a9f541716f4d4cf1faf4182';

abstract class _$VariantPod extends $AsyncNotifier<Variant> {
  FutureOr<Variant> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Variant>, Variant>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Variant>, Variant>,
              AsyncValue<Variant>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
