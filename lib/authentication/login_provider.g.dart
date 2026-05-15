// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(login)
final loginProvider = LoginProvider._();

final class LoginProvider
    extends $FunctionalProvider<LoginState, LoginState, LoginState>
    with $Provider<LoginState> {
  LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[asyncLoginProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          LoginProvider.$allTransitiveDependencies0,
          LoginProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = asyncLoginProvider;
  static final $allTransitiveDependencies1 =
      AsyncLoginNotifierProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  $ProviderElement<LoginState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoginState create(Ref ref) {
    return login(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginState>(value),
    );
  }
}

String _$loginHash() => r'da56a35ece917d7ae9ec04b19bc25dae1533e70e';
