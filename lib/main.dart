import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Voice Assistant',
      home: VoiceAssistantPage(),
    );
  }
}

class VoiceAssistantPage extends StatefulWidget {
  const VoiceAssistantPage({super.key});

  @override
  _VoiceAssistantPageState createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isSessionActive = false;
  String _sessionStatus = "Session is not started yet.";
  String _userResponse = "";
  
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  void _startSession() async {
    setState(() {
      _isSessionActive = true;
      _sessionStatus = "Session Started. Respond to the commands.";
    });

    await _flutterTts.speak("Feel the joy");

    _startListening();
  }

  void _endSession() async {
    setState(() {
      _isSessionActive = false;
      _sessionStatus = "Session Ended.";
    });

    _speech.stop();
    await _flutterTts.stop();
  }

  void _startListening() async {
    if (await _speech.initialize()) {
      setState(() {
        _userResponse = "";
      });

      _speech.listen(onResult: (result) {
        setState(() {
          _userResponse = result.recognizedWords;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _sessionStatus,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _userResponse.isEmpty ? '' : 'You said: $_userResponse',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isSessionActive ? _endSession : _startSession,
              child: Text(_isSessionActive ? 'End Session' : 'Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
