// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatNotifier)
final chatProvider = ChatNotifierFamily._();

final class ChatNotifierProvider
    extends $NotifierProvider<ChatNotifier, CurrentChatState> {
  ChatNotifierProvider._({
    required ChatNotifierFamily super.from,
    required ChatChannel super.argument,
  }) : super(
         retry: null,
         name: r'chatProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = chatControllerProvider;
  static final $allTransitiveDependencies1 =
      ChatControllerNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ChatControllerNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ChatControllerNotifierProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ChatControllerNotifierProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      ChatControllerNotifierProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      ChatControllerNotifierProvider.$allTransitiveDependencies5;
  static final $allTransitiveDependencies7 =
      ChatControllerNotifierProvider.$allTransitiveDependencies6;
  static final $allTransitiveDependencies8 =
      ChatControllerNotifierProvider.$allTransitiveDependencies7;
  static final $allTransitiveDependencies9 =
      ChatControllerNotifierProvider.$allTransitiveDependencies8;
  static final $allTransitiveDependencies10 =
      ChatControllerNotifierProvider.$allTransitiveDependencies9;

  @override
  String debugGetCreateSourceHash() => _$chatNotifierHash();

  @override
  String toString() {
    return r'chatProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatNotifier create() => ChatNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentChatState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatNotifierHash() => r'0b382ed27f9212f9b606544c142178de8ee2916d';

final class ChatNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatNotifier,
          CurrentChatState,
          CurrentChatState,
          CurrentChatState,
          ChatChannel
        > {
  ChatNotifierFamily._()
    : super(
        retry: null,
        name: r'chatProvider',
        dependencies: <ProviderOrFamily>[chatControllerProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatNotifierProvider.$allTransitiveDependencies0,
          ChatNotifierProvider.$allTransitiveDependencies1,
          ChatNotifierProvider.$allTransitiveDependencies2,
          ChatNotifierProvider.$allTransitiveDependencies3,
          ChatNotifierProvider.$allTransitiveDependencies4,
          ChatNotifierProvider.$allTransitiveDependencies5,
          ChatNotifierProvider.$allTransitiveDependencies6,
          ChatNotifierProvider.$allTransitiveDependencies7,
          ChatNotifierProvider.$allTransitiveDependencies8,
          ChatNotifierProvider.$allTransitiveDependencies9,
          ChatNotifierProvider.$allTransitiveDependencies10,
        },
        isAutoDispose: true,
      );

  ChatNotifierProvider call(ChatChannel channel) =>
      ChatNotifierProvider._(argument: channel, from: this);

  @override
  String toString() => r'chatProvider';
}

abstract class _$ChatNotifier extends $Notifier<CurrentChatState> {
  late final _$args = ref.$arg as ChatChannel;
  ChatChannel get channel => _$args;

  CurrentChatState build(ChatChannel channel);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
