// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AsyncLoginNotifier)
final asyncLoginProvider = AsyncLoginNotifierProvider._();

final class AsyncLoginNotifierProvider
    extends $AsyncNotifierProvider<AsyncLoginNotifier, LoginState> {
  AsyncLoginNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncLoginProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[storagesProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          AsyncLoginNotifierProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = storagesProvider;

  @override
  String debugGetCreateSourceHash() => _$asyncLoginNotifierHash();

  @$internal
  @override
  AsyncLoginNotifier create() => AsyncLoginNotifier();
}

String _$asyncLoginNotifierHash() =>
    r'5b3e05ec011d9dc64af8e293e35d58efb6661ce8';

abstract class _$AsyncLoginNotifier extends $AsyncNotifier<LoginState> {
  FutureOr<LoginState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LoginState>, LoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LoginState>, LoginState>,
              AsyncValue<LoginState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
