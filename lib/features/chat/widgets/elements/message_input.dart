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
  var input = '';

  bool get isNotEmpty {
    return input.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    input = widget.textEditingController.value.text;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [textInput(), sendButton()],
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

  Widget textInput() {
    final theme = Theme.of(context);

    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 8),
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
          onChanged: (value) => setState(() {
            input = value;
          }),
          onSubmitted: ((value) =>
              isNotEmpty ? widget.onMessageSubmitted(value.trim()) : null),
        ),
      ),
    );
  }
}
