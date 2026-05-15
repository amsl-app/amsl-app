// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Focus)
final focusProvider = FocusProvider._();

final class FocusProvider
    extends $AsyncNotifierProvider<Focus, Map<String, JournalFocus>> {
  FocusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'focusProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          FocusProvider.$allTransitiveDependencies0,
          FocusProvider.$allTransitiveDependencies1,
          FocusProvider.$allTransitiveDependencies2,
          FocusProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$focusHash();

  @$internal
  @override
  Focus create() => Focus();
}

String _$focusHash() => r'27e70e77ebd9ce0c8da7c79de7d5c47a002e0db3';

abstract class _$Focus extends $AsyncNotifier<Map<String, JournalFocus>> {
  FutureOr<Map<String, JournalFocus>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, JournalFocus>>,
              Map<String, JournalFocus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, JournalFocus>>,
                Map<String, JournalFocus>
              >,
              AsyncValue<Map<String, JournalFocus>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
