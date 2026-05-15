// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatControllerNotifier)
final chatControllerProvider = ChatControllerNotifierProvider._();

final class ChatControllerNotifierProvider
    extends $NotifierProvider<ChatControllerNotifier, ChatController> {
  ChatControllerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          chatRepositoryProvider,
          chatChannelProvider,
          moduleProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatControllerNotifierProvider.$allTransitiveDependencies0,
          ChatControllerNotifierProvider.$allTransitiveDependencies1,
          ChatControllerNotifierProvider.$allTransitiveDependencies2,
          ChatControllerNotifierProvider.$allTransitiveDependencies3,
          ChatControllerNotifierProvider.$allTransitiveDependencies4,
          ChatControllerNotifierProvider.$allTransitiveDependencies5,
          ChatControllerNotifierProvider.$allTransitiveDependencies6,
          ChatControllerNotifierProvider.$allTransitiveDependencies7,
          ChatControllerNotifierProvider.$allTransitiveDependencies8,
          ChatControllerNotifierProvider.$allTransitiveDependencies9,
        },
      );

  static final $allTransitiveDependencies0 = chatRepositoryProvider;
  static final $allTransitiveDependencies1 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      ChatRepositoryNotifierProvider.$allTransitiveDependencies5;
  static final $allTransitiveDependencies7 = moduleProvider;
  static final $allTransitiveDependencies8 =
      ModuleNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies9 =
      ModuleNotifierProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$chatControllerNotifierHash();

  @$internal
  @override
  ChatControllerNotifier create() => ChatControllerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatController>(value),
    );
  }
}

String _$chatControllerNotifierHash() =>
    r'ae018b7515c03426024ae8b42ee3a20dca1d139c';

abstract class _$ChatControllerNotifier extends $Notifier<ChatController> {
  ChatController build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ChatController, ChatController>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatController, ChatController>,
              ChatController,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
