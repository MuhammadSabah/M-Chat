import 'package:final_chat_app/src/features/chat/widgets/my_message_card.dart';
import 'package:final_chat_app/src/features/chat/widgets/sender_message_card.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return MyMessageCard();
      },
    );
  }
}
