import 'package:amsl_app/features/chat/repository/channel_source.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_channel.g.dart';
part 'chat_channel.freezed.dart';

String channelKey(String moduleId, String sessionId) {
  return "$moduleId-\$-$sessionId";
}

@freezed
sealed class ChatChannel with _$ChatChannel {
  const factory ChatChannel({
    required String moduleId,
    required String sessionId,
    required bool stream,
  }) = _ChatChannel;

  factory ChatChannel.fromSession(Session session) {
    final moduleId = session.module.target?.id;
    if (moduleId == null) {
      throw "Modules not loaded";
    }
    return ChatChannel(
      moduleId: moduleId,
      sessionId: session.id,
      stream: session.isLlm,
    );
  }

  @override
  String toString() {
    final name = switch (stream) {
      true => "StreamChannel",
      false => "ChatChannel",
    };
    return "$name(mid: $moduleId, sid: $sessionId)";
  }
}

@Riverpod(keepAlive: true, dependencies: [HikariPod])
final class ChatChannelNotifier extends _$ChatChannelNotifier {
  static final log = Logger("ChatChannelNotifier");
  late Hikari hikari;

  @override
  ChatChannelSource build(ChatChannel chatChannel) {
    log.finer("rebuilding chat channel for $chatChannel");
    hikari = ref.watch(hikariPodProvider);
    final ChatChannelSource repo;
    if (chatChannel.stream) {
      repo = ChannelChatStepStream(
        moduleId: chatChannel.moduleId,
        sessionId: chatChannel.sessionId,
        hikari: hikari,
      );
    } else {
      repo = ChannelChatStepStore(
        moduleId: chatChannel.moduleId,
        sessionId: chatChannel.sessionId,
        hikari: hikari,
      );
    }
    return repo;
  }
}
