// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storages)
final storagesProvider = StoragesProvider._();

final class StoragesProvider
    extends $FunctionalProvider<Storages, Storages, Storages>
    with $Provider<Storages> {
  StoragesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storagesProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$storagesHash();

  @$internal
  @override
  $ProviderElement<Storages> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Storages create(Ref ref) {
    return storages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Storages value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Storages>(value),
    );
  }
}

String _$storagesHash() => r'6da17a25c3097eb934aa671f4158c02aae992b1e';
