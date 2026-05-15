import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/repository/channel_repository.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/repository/chat_controller.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_stream.g.dart';

@Riverpod(dependencies: [ChatControllerNotifier])
class ChatStreamNotifier extends _$ChatStreamNotifier {
  static final log = Logger("ChatStreamNotifier");

  @override
  Stream<List<Message>> build(ChatChannel channel) async* {
    final controller = ref.watch(chatControllerProvider.notifier);

    final ChatChannelRepositoryNotifier repository = controller
        .getChannelRepository(channel);

    final List<Message>? initialMessages = repository.messages;

    if (initialMessages != null) {
      log.info("Yielding ${initialMessages.length} initial messages");
      yield initialMessages;
    }

    await for (final messages in controller.chatStream(channel).map((event) {
      log.info("Got message: $event");
      return event;
    })) {
      yield messages;
    }
  }
}
