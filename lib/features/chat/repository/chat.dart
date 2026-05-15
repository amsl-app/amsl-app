import 'dart:async';

import 'package:amsl_app/features/chat/models/chat_state.dart';
import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/chat/repository/chat_controller.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat.g.dart';

@Riverpod(dependencies: [ChatControllerNotifier])
class ChatNotifier extends _$ChatNotifier {
  static final log = Logger("ChatNotifier");
  late final StreamSubscription<dynamic> subscription;

  @override
  CurrentChatState build(ChatChannel channel) {
    log.finer("rebuilding for $channel");
    final controller = ref.watch(chatControllerProvider.notifier);
    final state = controller.getState(channel);
    subscription = controller.stateStream(channel).listen(update);
    ref.onDispose(subscription.cancel);
    return state;
  }

  void update(CurrentChatState newState) {
    state = newState;
  }
}
