import 'package:flutter/material.dart';

class ChatMessagesScreen extends StatelessWidget {
  const ChatMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text('Hello'),
        ),
      ),
    );
  }
}
