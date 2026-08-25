import 'package:amsl_app/features/voice/voice_button.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final int maxLines;
  final String? hint;

  const MessageInput({
    required this.textEditingController,
    required this.onMessageSubmitted,
    required this.onSendButtonPressed,
    required this.allowInput,
    this.maxLines = 3,
    this.hint,
    this.focusNode,
    super.key,
  });

  final Function(String) onMessageSubmitted;
  final VoidCallback onSendButtonPressed;
  final TextEditingController textEditingController;
  final bool allowInput;
  final FocusNode? focusNode;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool voiceActive = false;

  bool get isNotEmpty {
    return widget.textEditingController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        // bottom: 16.0,
        top: 4.0,
      ),
      child: textInputRow(),
    );
  }

  Widget textInputRow() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 2),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textInput(),
            voiceInputButton(),
            if (isNotEmpty) sendButton(),
          ],
        ),
      ),
    );
  }

  Widget sendButton() {
    return Visibility(
      visible: isNotEmpty,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: widget.onSendButtonPressed,
          ),
        ),
      ),
    );
  }

  Widget voiceInputButton() {
    return VoiceButton(
      textEditingController: widget.textEditingController,
      onStart: () => setState(() {
        voiceActive = true;
      }),
      onEnd: (_) => setState(() {
        voiceActive = false;
      }),
    );
  }

  Widget textInput() {
    final theme = Theme.of(context);

    return Flexible(
      child: TextField(
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        enabled: widget.allowInput,
        maxLines: widget.maxLines,
        minLines: 1,
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.allowInput
              ? (widget.hint ?? "Schreib etwas...")
              : '',
          border: InputBorder.none,
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: ((value) =>
            isNotEmpty ? widget.onMessageSubmitted(value.trim()) : null),
      ),
    );
  }
}
