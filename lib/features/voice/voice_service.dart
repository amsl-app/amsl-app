import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// Ein einfaches Rückgabe-Objekt (oder Dart 3 Record),
// um die Werte im UI leicht zugänglich zu machen.
class SpeechState {
  final String text;
  final bool isListening;
  final bool isInitialized;
  final Future<void> Function({String? presetText}) startRecording;
  final Future<void> Function() stopRecording;

  SpeechState({
    required this.text,
    required this.isListening,
    required this.isInitialized,
    required this.startRecording,
    required this.stopRecording,
  });
}

SpeechState useSpeechToText({
  Function(String text)? onComplete,
  Function(String text)? onChange,
  Function(dynamic error)? onError,
}) {
  final log = Logger("SpeechToTextHook");

  final speech = useMemoized(() => stt.SpeechToText());

  final text = useState("");
  final isListening = useState(false);
  final isInitialized = useState(false);

  useEffect(() {
    Future<void> initSpeech() async {
      final res = await speech.initialize(
        onStatus: (status) {
          if (status == "done" && !speech.hasError) {
            log.info("Speech recognition done: ${text.value}");
            if (onComplete != null) onComplete(text.value);
            isListening.value = false;
          }
          if (status == "listening") {
            isListening.value = true;
          }
        },
        onError: (error) {
          log.severe("Speech recognition error: ${error.errorMsg}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isListening.value = false;
          });
          if (onError != null) onError(error);
        },
      );

      log.info("Speech recognition initialized: $res");
      isInitialized.value = res;
    }

    initSpeech();

    return () {
      if (speech.isListening) {
        log.info("Hook disposed: Canceling speech recognition");
        speech
            .cancel(); // Besser als stop() beim Beenden, um Fehler zu vermeiden
      }
    };
  }, [speech]);

  Future<void> startRecording({String? presetText}) async {
    if (!isInitialized.value) return;

    HapticFeedback.heavyImpact();
    log.info("Activate microphone");
    text.value = presetText ?? "";

    await speech.listen(
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        localeId: "de-DE",
        pauseFor: const Duration(seconds: 2),
        onDevice: true,
      ),
      onResult: (result) {
        text.value = result.recognizedWords.trim();
        if (onChange != null) onChange(text.value);
      },
    );
  }

  Future<void> stopRecording({int iteration = 0}) async {
    HapticFeedback.mediumImpact();
    log.info("Deactivate microphone");
    try {
      await speech.stop().timeout(const Duration(seconds: 1));
      isListening.value = false;
    } catch (e) {
      log.warning("Speech stop timeout, retrying: $e");
      if (iteration < 3) {
        await stopRecording(iteration: iteration + 1);
      } else {
        log.severe("Failed to stop speech recognition after 3 attempts");
        if (onError != null) onError(e);
      }
    }
  }

  return SpeechState(
    text: text.value,
    isListening: isListening.value,
    isInitialized: isInitialized.value,
    startRecording: startRecording,
    stopRecording: stopRecording,
  );
}
