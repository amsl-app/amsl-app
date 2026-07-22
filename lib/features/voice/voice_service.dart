import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextService {
  static final log = Logger("SpeechToTextService");

  SpeechToTextService({
    this.onChange,
    this.onComplete,
    this.onStart,
    this.onError,
  }) : speech = stt.SpeechToText();

  final Function(String text)? onChange;
  final Function(String text)? onComplete;
  final Function(dynamic error)? onError;
  final Function()? onStart;

  late stt.SpeechToText speech;
  String _currentText = "";
  bool initalized = false;

  Future initialize(BuildContext context) async {
    if (initalized) return true;
    final res = await speech.initialize(
      onStatus: (status) {
        if (status == "done" && !speech.hasError) {
          log.info("Speech recognition done: $_currentText");

          if (onComplete != null) onComplete!(_currentText);
          _currentText = "";
        }
        if (status == "listening") {
          if (onStart != null) onStart!();
        }
      },
      onError: (error) {
        log.severe("Speech recognition error: ${error.errorMsg}");
        if (onError != null) onError!(error);
      },
    );
    log.info("Speech recognition initialized: $res");
    initalized = res;
    return initalized;
  }

  Future startRecording() async {
    HapticFeedback.heavyImpact();
    log.info("Activate microphone");
    await speech.listen(
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        onDevice: true,
      ),
      localeId: "de",
      pauseFor: Duration(seconds: 2),
      onResult: (result) {
        _currentText = result.recognizedWords.trim();
        if (onChange != null) onChange!(_currentText);
      },
    );
  }

  Future stopRecording({int iteration = 0}) async {
    HapticFeedback.mediumImpact();
    log.info("Deactivate microphone");
    try {
      await speech.stop().timeout(Duration(seconds: 1));
    } catch (e) {
      log.warning("Speech stop timeout, retrying: $e");
      if (iteration < 3) {
        await stopRecording(iteration: iteration + 1);
      } else {
        log.severe("Failed to stop speech recognition after 3 attempts");
        if (onError != null) onError!(e);
      }
    }
  }
}
