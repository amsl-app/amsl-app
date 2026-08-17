import 'package:amsl_app/features/voice/voice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VoiceButton extends HookWidget {
  const VoiceButton({
    super.key,
    required this.textEditingController,
    this.onStart,
    this.onEnd,
  });
  final TextEditingController textEditingController;
  final Function()? onStart;
  final Function(String text)? onEnd;

  @override
  Widget build(BuildContext context) {
    final speech = useSpeechToText(
      onChange: (text) => textEditingController.text = text,
    );

    return CircleAvatar(
      backgroundColor: speech.isListening
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
          : Colors.transparent,
      radius: 20,
      child: IconButton(
        icon: Icon(color: Theme.of(context).colorScheme.primary, Icons.mic),
        onPressed: () async {
          if (speech.isListening) {
            await speech.stopRecording();
          } else {
            await speech.startRecording(presetText: textEditingController.text);
          }
        },
      ),
    );
  }
}
