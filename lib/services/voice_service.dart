import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  String _lastError = "";

  bool get isListening => _speechToText.isListening;
  String get lastError => _lastError;

  Future<bool> initSpeech() async {
    return await _speechToText.initialize(
      onError: (val) {
        _lastError = val.errorMsg;
        print('VoiceService Error: ${val.errorMsg}');
        notifyListeners();
      },
      onStatus: (val) {
        print('VoiceService Status: $val');
        notifyListeners();
      },
    );
  }

  Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onPartialResult,
  }) async {
    _lastError = "";
    print("VoiceService: Attempting to start listening...");
    await _speechToText.listen(
      onResult: (result) {
        print(
          "VoiceService: Result: ${result.recognizedWords} (Final: ${result.finalResult})",
        );
        if (result.finalResult) {
          onResult(result.recognizedWords);
        } else {
          onPartialResult(result.recognizedWords);
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 2),
      partialResults: true,
      cancelOnError: true,
      listenMode: ListenMode.deviceDefault,
    );
    notifyListeners();
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    notifyListeners();
  }

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.7);
    await _flutterTts.speak(text);
  }
}
