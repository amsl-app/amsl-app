// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_channel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatChannelNotifier)
final chatChannelProvider = ChatChannelNotifierFamily._();

final class ChatChannelNotifierProvider
    extends $NotifierProvider<ChatChannelNotifier, ChatChannelSource> {
  ChatChannelNotifierProvider._({
    required ChatChannelNotifierFamily super.from,
    required ChatChannel super.argument,
  }) : super(
         retry: null,
         name: r'chatChannelProvider',
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

  @override
  String debugGetCreateSourceHash() => _$chatChannelNotifierHash();

  @override
  String toString() {
    return r'chatChannelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatChannelNotifier create() => ChatChannelNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatChannelSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatChannelSource>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatChannelNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatChannelNotifierHash() =>
    r'd242ce426f06b8bbd3672d813b77f1bf6b052c5c';

final class ChatChannelNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatChannelNotifier,
          ChatChannelSource,
          ChatChannelSource,
          ChatChannelSource,
          ChatChannel
        > {
  ChatChannelNotifierFamily._()
    : super(
        retry: null,
        name: r'chatChannelProvider',
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatChannelNotifierProvider.$allTransitiveDependencies0,
          ChatChannelNotifierProvider.$allTransitiveDependencies1,
          ChatChannelNotifierProvider.$allTransitiveDependencies2,
          ChatChannelNotifierProvider.$allTransitiveDependencies3,
        },
        isAutoDispose: false,
      );

  ChatChannelNotifierProvider call(ChatChannel chatChannel) =>
      ChatChannelNotifierProvider._(argument: chatChannel, from: this);

  @override
  String toString() => r'chatChannelProvider';
}

abstract class _$ChatChannelNotifier extends $Notifier<ChatChannelSource> {
  late final _$args = ref.$arg as ChatChannel;
  ChatChannel get chatChannel => _$args;

  ChatChannelSource build(ChatChannel chatChannel);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ChatChannelSource, ChatChannelSource>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatChannelSource, ChatChannelSource>,
              ChatChannelSource,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
