import 'package:amsl_app/features/chat/repository/chat_channel.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/variants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../models/tori/modules/session.dart';
import '../../../../widgets/error/error_bar.dart';
import '../../../chat/repository/chat_controller.dart';
import '../../../journal/widgets/entry/chat_overlay.dart';

class ChatJournalInput extends StatefulHookConsumerWidget {
  ChatJournalInput({
    required this.textEditingController,
    required this.onMessageSubmitted,
    required this.onSendButtonPressed,
    required this.allowInput,
    required this.session,
    required this.requireAssistant,
    this.focusNode,
    super.key,
  }) : channel = ChatChannel.fromSession(session);

  final Function(String) onMessageSubmitted;
  final VoidCallback onSendButtonPressed;
  final TextEditingController textEditingController;
  final bool allowInput;
  final FocusNode? focusNode;
  final Session session;
  final bool requireAssistant;
  final ChatChannel channel;

  @override
  ConsumerState<ChatJournalInput> createState() => _ChatJournalInputState();
}

class _ChatJournalInputState extends ConsumerState<ChatJournalInput> {
  var input = '';

  bool get isNotEmpty {
    return input.trim().isNotEmpty;
  }

  bool assistantUsed = false;
  bool textEditedAfterAssistantUsage = false;
  int? assistantOptionSelected;

  bool get requireAssistant => widget.requireAssistant;

  @override
  Widget build(BuildContext context) {
    final variant = ref.watch(variantPodProvider).value;

    if (variant == null) {
      // This should never happen
      return Container();
    }
    input = widget.textEditingController.value.text;
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 4.0,
        top: 4.0,
      ),
      child: textInputRow(variant),
    );
  }

  Widget textInputRow(Variant variant) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 2),
            color: Colors.white,
          ),
          child: textInput(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              requireAssistant && !assistantUsed
                  ? GlowContainer(
                      glowColor: theme.colorScheme.tertiary,
                      child: gptHelp(),
                    )
                  : gptHelp(),
              const Gap(8.0),
              sendButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget sendButton() {
    final theme = Theme.of(context);
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: isNotEmpty && (!requireAssistant || assistantUsed)
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withValues(alpha: 0.5),
          child: Ink(
            child: InkWell(
              onTap: () {
                if (requireAssistant && !assistantUsed) {
                  showMessage(
                    context,
                    label:
                        "Lasse dir testweise bei der Erstellung deiner Antwort vom Assistenten helfen.",
                  );
                  return;
                }
                if (isNotEmpty) {
                  widget.onSendButtonPressed();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Center(
                  child: Text(
                    'Senden',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gptHelp() {
    final theme = Theme.of(context);
    return Visibility(
      visible: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: const Color.fromRGBO(181, 226, 240, 1.0),
          child: Ink(
            child: InkWell(
              onTap: () async {
                if (!isNotEmpty) {
                  showMessage(
                    context,
                    label:
                        "Bitte schreibe etwas zu der Frage, damit ich dir helfen kann.",
                  );
                  return;
                }
                assistantUsed = true;
                startAssistant();
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: requireAssistant && !assistantUsed
                        ? theme.colorScheme.tertiary
                        : theme.colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/images/avatar_images/avatar_centered.svg",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startAssistant() {
    final prompt = ref
        .read(chatControllerProvider.notifier)
        .getState(widget.channel)
        .journalContentInput
        ?.prompt;

    if (prompt == null) return;

    setState(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChatOverlay(
            initialInput: widget.textEditingController.text,
            firstPrompt: prompt,
            callback: (String input, int index) {
              setState(() {
                textEditedAfterAssistantUsage = false;
                assistantOptionSelected = index;
                widget.textEditingController.text = input;
              });
            },
          );
        },
      );
    });
  }

  void onMessageSubmitted(String value) {
    String eventName = "custom";
    if (assistantOptionSelected != null) {
      eventName = "assistant-option-$assistantOptionSelected";
    }
    trackEvent(
      category: TrackingCategory.journalMessage,
      action: TrackingAction.submit,
      name: eventName,
      value: assistantOptionSelected,
    );
    widget.onMessageSubmitted(value.trim());
  }

  Widget textInput() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        enabled: widget.allowInput,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        minLines: 3,
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.allowInput ? "Schreib etwas..." : '',
          border: InputBorder.none,
        ),
        onChanged: (value) => setState(() {
          if (assistantOptionSelected != null) {
            textEditedAfterAssistantUsage = false;
          }
          input = value;
        }),
        onSubmitted: ((value) => isNotEmpty ? onMessageSubmitted(value) : null),
      ),
    );
  }
}
