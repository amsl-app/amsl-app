import 'package:amsl_app/features/chat/widgets/chat_screen/chat_input_overlay.dart';
import 'package:amsl_app/features/chat/widgets/elements/scroll_methods.dart';
import 'package:amsl_app/models/tori/modules/session.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chat_history.dart';

class ChatFrontLayer extends StatefulHookConsumerWidget {
  final Session session;
  const ChatFrontLayer({super.key, required this.session});

  @override
  ConsumerState<ChatFrontLayer> createState() => _ChatFrontLayerState();
}

class _ChatFrontLayerState extends ConsumerState<ChatFrontLayer> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: theme.colorScheme.surfaceContainer,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ChatHistory(
                    scrollController: _scrollController,
                    session: widget.session,
                  ),
                ),
                ChatInputOverlay(
                  onSubmit: onMessageSubmitted,
                  maxHeight: constraints.maxHeight,
                  session: widget.session,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onMessageSubmitted() async {
    setState(() {
      scrollToBottom(_scrollController);
    });
  }
}
