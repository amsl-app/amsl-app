// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatChannelRepositoryNotifier)
final chatChannelRepositoryProvider = ChatChannelRepositoryNotifierFamily._();

final class ChatChannelRepositoryNotifierProvider
    extends $NotifierProvider<ChatChannelRepositoryNotifier, CurrentChatState> {
  ChatChannelRepositoryNotifierProvider._({
    required ChatChannelRepositoryNotifierFamily super.from,
    required ChatChannel super.argument,
  }) : super(
         retry: null,
         name: r'chatChannelRepositoryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 = chatChannelProvider;

  @override
  String debugGetCreateSourceHash() => _$chatChannelRepositoryNotifierHash();

  @override
  String toString() {
    return r'chatChannelRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatChannelRepositoryNotifier create() => ChatChannelRepositoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentChatState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatChannelRepositoryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatChannelRepositoryNotifierHash() =>
    r'45c49a4a076225cb1fb408b2b0267b2b2239027c';

final class ChatChannelRepositoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatChannelRepositoryNotifier,
          CurrentChatState,
          CurrentChatState,
          CurrentChatState,
          ChatChannel
        > {
  ChatChannelRepositoryNotifierFamily._()
    : super(
        retry: null,
        name: r'chatChannelRepositoryProvider',
        dependencies: <ProviderOrFamily>[
          hikariPodProvider,
          chatChannelProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies0,
          ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies1,
          ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies2,
          ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies3,
          ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: false,
      );

  ChatChannelRepositoryNotifierProvider call({required ChatChannel channel}) =>
      ChatChannelRepositoryNotifierProvider._(argument: channel, from: this);

  @override
  String toString() => r'chatChannelRepositoryProvider';
}

abstract class _$ChatChannelRepositoryNotifier
    extends $Notifier<CurrentChatState> {
  late final _$args = ref.$arg as ChatChannel;
  ChatChannel get channel => _$args;

  CurrentChatState build({required ChatChannel channel});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrentChatState, CurrentChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrentChatState, CurrentChatState>,
              CurrentChatState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(channel: _$args));
  }
}
