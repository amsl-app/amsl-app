// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

final class AppVersionProvider
    extends $FunctionalProvider<AsyncValue<Version>, Version, FutureOr<Version>>
    with $FutureModifier<Version>, $FutureProvider<Version> {
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[packageInfoProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          AppVersionProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = packageInfoProvider;

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<Version> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Version> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'efc9087da387732aad4f42d4d50fa77536650f02';

@ProviderFor(UpdateData)
final updateDataProvider = UpdateDataProvider._();

final class UpdateDataProvider
    extends $NotifierProvider<UpdateData, UpdateInfo> {
  UpdateDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDataProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          appVersionProvider,
          minVersionProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>[
          UpdateDataProvider.$allTransitiveDependencies0,
          UpdateDataProvider.$allTransitiveDependencies1,
          UpdateDataProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = appVersionProvider;
  static final $allTransitiveDependencies1 =
      AppVersionProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = minVersionProvider;

  @override
  String debugGetCreateSourceHash() => _$updateDataHash();

  @$internal
  @override
  UpdateData create() => UpdateData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateInfo>(value),
    );
  }
}

String _$updateDataHash() => r'4572e0d4c6b666162a49ce8ddcd4731d28339c6e';

abstract class _$UpdateData extends $Notifier<UpdateInfo> {
  UpdateInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UpdateInfo, UpdateInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateInfo, UpdateInfo>,
              UpdateInfo,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
