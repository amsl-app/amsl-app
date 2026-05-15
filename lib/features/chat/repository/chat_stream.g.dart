// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatStreamNotifier)
final chatStreamProvider = ChatStreamNotifierFamily._();

final class ChatStreamNotifierProvider
    extends $StreamNotifierProvider<ChatStreamNotifier, List<Message>> {
  ChatStreamNotifierProvider._({
    required ChatStreamNotifierFamily super.from,
    required ChatChannel super.argument,
  }) : super(
         retry: null,
         name: r'chatStreamProvider',
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
  String debugGetCreateSourceHash() => _$chatStreamNotifierHash();

  @override
  String toString() {
    return r'chatStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatStreamNotifier create() => ChatStreamNotifier();

  @override
  bool operator ==(Object other) {
    return other is ChatStreamNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatStreamNotifierHash() =>
    r'417eb844a225401ca7b2caa393b48fc9deaa11c4';

final class ChatStreamNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatStreamNotifier,
          AsyncValue<List<Message>>,
          List<Message>,
          Stream<List<Message>>,
          ChatChannel
        > {
  ChatStreamNotifierFamily._()
    : super(
        retry: null,
        name: r'chatStreamProvider',
        dependencies: <ProviderOrFamily>[chatControllerProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatStreamNotifierProvider.$allTransitiveDependencies0,
          ChatStreamNotifierProvider.$allTransitiveDependencies1,
          ChatStreamNotifierProvider.$allTransitiveDependencies2,
          ChatStreamNotifierProvider.$allTransitiveDependencies3,
          ChatStreamNotifierProvider.$allTransitiveDependencies4,
          ChatStreamNotifierProvider.$allTransitiveDependencies5,
          ChatStreamNotifierProvider.$allTransitiveDependencies6,
          ChatStreamNotifierProvider.$allTransitiveDependencies7,
          ChatStreamNotifierProvider.$allTransitiveDependencies8,
          ChatStreamNotifierProvider.$allTransitiveDependencies9,
          ChatStreamNotifierProvider.$allTransitiveDependencies10,
        },
        isAutoDispose: true,
      );

  ChatStreamNotifierProvider call(ChatChannel channel) =>
      ChatStreamNotifierProvider._(argument: channel, from: this);

  @override
  String toString() => r'chatStreamProvider';
}

abstract class _$ChatStreamNotifier extends $StreamNotifier<List<Message>> {
  late final _$args = ref.$arg as ChatChannel;
  ChatChannel get channel => _$args;

  Stream<List<Message>> build(ChatChannel channel);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Message>>, List<Message>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Message>>, List<Message>>,
              AsyncValue<List<Message>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
