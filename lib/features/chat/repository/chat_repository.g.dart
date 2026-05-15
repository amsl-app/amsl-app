// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatRepositoryNotifier)
final chatRepositoryProvider = ChatRepositoryNotifierFamily._();

final class ChatRepositoryNotifierProvider
    extends
        $NotifierProvider<
          ChatRepositoryNotifier,
          ChatChannelRepositoryNotifier
        > {
  ChatRepositoryNotifierProvider._({
    required ChatRepositoryNotifierFamily super.from,
    required ChatChannel super.argument,
  }) : super(
         retry: null,
         name: r'chatRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = chatChannelRepositoryProvider;
  static final $allTransitiveDependencies1 =
      ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      ChatChannelRepositoryNotifierProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryNotifierHash();

  @override
  String toString() {
    return r'chatRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatRepositoryNotifier create() => ChatRepositoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatChannelRepositoryNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatChannelRepositoryNotifier>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRepositoryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatRepositoryNotifierHash() =>
    r'4e6f1efd182bf3b3daba4b4e3adbaef79f216b6d';

final class ChatRepositoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatRepositoryNotifier,
          ChatChannelRepositoryNotifier,
          ChatChannelRepositoryNotifier,
          ChatChannelRepositoryNotifier,
          ChatChannel
        > {
  ChatRepositoryNotifierFamily._()
    : super(
        retry: null,
        name: r'chatRepositoryProvider',
        dependencies: <ProviderOrFamily>[chatChannelRepositoryProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ChatRepositoryNotifierProvider.$allTransitiveDependencies0,
          ChatRepositoryNotifierProvider.$allTransitiveDependencies1,
          ChatRepositoryNotifierProvider.$allTransitiveDependencies2,
          ChatRepositoryNotifierProvider.$allTransitiveDependencies3,
          ChatRepositoryNotifierProvider.$allTransitiveDependencies4,
          ChatRepositoryNotifierProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  ChatRepositoryNotifierProvider call(ChatChannel channel) =>
      ChatRepositoryNotifierProvider._(argument: channel, from: this);

  @override
  String toString() => r'chatRepositoryProvider';
}

abstract class _$ChatRepositoryNotifier
    extends $Notifier<ChatChannelRepositoryNotifier> {
  late final _$args = ref.$arg as ChatChannel;
  ChatChannel get channel => _$args;

  ChatChannelRepositoryNotifier build(ChatChannel channel);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ChatChannelRepositoryNotifier,
              ChatChannelRepositoryNotifier
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ChatChannelRepositoryNotifier,
                ChatChannelRepositoryNotifier
              >,
              ChatChannelRepositoryNotifier,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
