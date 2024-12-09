import 'package:flutter/material.dart';
import 'services/speech_service.dart';
import 'widgets/session_button.dart';
import 'widgets/status_text.dart';
import 'models/user_response.dart';

void main() {
  runApp(SpeechRecognitionApp());
}

class SpeechRecognitionApp extends StatefulWidget {
  @override
  _SpeechRecognitionAppState createState() => _SpeechRecognitionAppState();
}

class _SpeechRecognitionAppState extends State<SpeechRecognitionApp> {
  final SpeechService _speechService = SpeechService();
  List<UserResponse> userResponses = [];
  String status = "App is ready";

  @override
  void initState() {
    super.initState();
    _speechService.initialize();
  }

  @override
  void dispose() {
    _speechService.dispose();
    super.dispose();
  }

  void startSession() {
    setState(() {
      status = "Listening for your response...";
    });

    _speechService.startListening((String response) {
      setState(() {
        userResponses.add(UserResponse(response: response));
        status = "Response recorded: $response";
      });
    });
  }

  void stopSession() {
    setState(() {
      status = "Session stopped.";
    });

    _speechService.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Speech Recognition App")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatusText(status: status),
              SizedBox(height: 20),
              SessionButton(
                isSessionActive: status == "Listening for your response...",
                startSession: startSession,
                stopSession: stopSession,
              ),
              SizedBox(height: 20),
              userResponses.isEmpty
                  ? Text(
                      "No responses recorded yet.",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: userResponses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                "Response ${index + 1}: ${userResponses[index].response}"),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
