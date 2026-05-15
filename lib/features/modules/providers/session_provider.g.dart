// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SessionPod)
final sessionPodProvider = SessionPodFamily._();

final class SessionPodProvider extends $NotifierProvider<SessionPod, Session?> {
  SessionPodProvider._({
    required SessionPodFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'sessionPodProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = moduleProvider;
  static final $allTransitiveDependencies1 =
      ModuleNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ModuleNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ModuleNotifierProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ModuleNotifierProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      ModuleNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      ModuleNotifierProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$sessionPodHash();

  @override
  String toString() {
    return r'sessionPodProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SessionPod create() => SessionPod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Session? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Session?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SessionPodProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionPodHash() => r'195eb28b71a64ef4731200f85c39e98984c4d00a';

final class SessionPodFamily extends $Family
    with
        $ClassFamilyOverride<
          SessionPod,
          Session?,
          Session?,
          Session?,
          (String, String)
        > {
  SessionPodFamily._()
    : super(
        retry: null,
        name: r'sessionPodProvider',
        dependencies: <ProviderOrFamily>[moduleProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          SessionPodProvider.$allTransitiveDependencies0,
          SessionPodProvider.$allTransitiveDependencies1,
          SessionPodProvider.$allTransitiveDependencies2,
          SessionPodProvider.$allTransitiveDependencies3,
          SessionPodProvider.$allTransitiveDependencies4,
          SessionPodProvider.$allTransitiveDependencies5,
          SessionPodProvider.$allTransitiveDependencies6,
        },
        isAutoDispose: true,
      );

  SessionPodProvider call(String moduleID, String sessionID) =>
      SessionPodProvider._(argument: (moduleID, sessionID), from: this);

  @override
  String toString() => r'sessionPodProvider';
}

abstract class _$SessionPod extends $Notifier<Session?> {
  late final _$args = ref.$arg as (String, String);
  String get moduleID => _$args.$1;
  String get sessionID => _$args.$2;

  Session? build(String moduleID, String sessionID);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Session?, Session?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Session?, Session?>,
              Session?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
