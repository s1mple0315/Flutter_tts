import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final String status;

  const StatusText({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
