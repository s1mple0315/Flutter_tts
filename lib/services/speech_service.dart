import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  // Initialize speech recognition
  Future<void> initialize() async {
    await _speechToText.initialize();
  }

  // Start listening for speech input
  void startListening(Function(String) onResponse) {
    if (_isListening) return;
    _isListening = true;
    _speechToText.listen(
      onResult: (result) {
        if (result.recognizedWords.isNotEmpty) {
          onResponse(result.recognizedWords);
        }
      },
    );
  }

  // Stop listening for speech input
  void stopListening() {
    if (!_isListening) return;
    _isListening = false;
    _speechToText.stop();
  }

  // Dispose of the speech service
  void dispose() {
    _speechToText.stop();
  }
}
