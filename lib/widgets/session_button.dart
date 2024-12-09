import 'package:flutter/material.dart';

class SessionButton extends StatelessWidget {
  final bool isSessionActive;
  final VoidCallback startSession;
  final VoidCallback stopSession;

  const SessionButton({
    Key? key,
    required this.isSessionActive,
    required this.startSession,
    required this.stopSession,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSessionActive ? stopSession : startSession,
      child: Text(isSessionActive ? "Stop Session" : "Start Session"),
    );
  }
}
