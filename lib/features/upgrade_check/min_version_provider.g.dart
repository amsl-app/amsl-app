// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'min_version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MinVersion)
final minVersionProvider = MinVersionProvider._();

final class MinVersionProvider
    extends $AsyncNotifierProvider<MinVersion, Version> {
  MinVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'minVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$minVersionHash();

  @$internal
  @override
  MinVersion create() => MinVersion();
}

String _$minVersionHash() => r'377d0361d1b63c3a625fb403caa7dc731ba5b0e4';

abstract class _$MinVersion extends $AsyncNotifier<Version> {
  FutureOr<Version> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Version>, Version>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Version>, Version>,
              AsyncValue<Version>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
