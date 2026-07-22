import 'package:amsl_app/features/voice/voice_service.dart';
import 'package:flutter/material.dart';

class VoiceButton extends StatefulWidget {
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
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> {
  var voiceActive = false;
  var ended = false; // To prevent multiple calls to onEnd
  var inputBeforeVoice = '';

  late SpeechToTextService speech;

  @override
  void initState() {
    speech = SpeechToTextService(
      onChange: (text) {
        widget.textEditingController.text = "$inputBeforeVoice $text";
      },
      onComplete: (_) => onEnd(),
      onError: (_) {
        // Revert any change to the controller
        widget.textEditingController.text = inputBeforeVoice;
        onEnd();
      },
    );
    super.initState();
  }

  void onEnd() {
    if (ended) return;
    if (widget.onEnd != null) {
      widget.onEnd!(widget.textEditingController.text);
    }
    setState(() {
      voiceActive = false;
      ended = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: voiceActive
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
          : Colors.transparent,
      radius: 20,
      child: IconButton(
        icon: Icon(color: Theme.of(context).colorScheme.primary, Icons.mic),
        onPressed: () async {
          if (voiceActive) {
            await speech.stopRecording();
            onEnd();
          } else {
            inputBeforeVoice = widget.textEditingController.text;
            setState(() {
              voiceActive = true;
              ended = false;
            });
            if (widget.onStart != null) widget.onStart!();
            await speech.initialize(context);
            await speech.startRecording();
          }
        },
      ),
    );
  }
}
