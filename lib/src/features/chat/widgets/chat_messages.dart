import 'package:final_chat_app/src/features/chat/controller/chat_controller.dart';
import 'package:final_chat_app/src/features/chat/widgets/my_message_card.dart';
import 'package:final_chat_app/src/features/chat/widgets/sender_message_card.dart';
import 'package:final_chat_app/src/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatMessages extends ConsumerStatefulWidget {
  ChatMessages({super.key, required this.receiverUserId});
  String receiverUserId;
  @override
  ConsumerState<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends ConsumerState<ChatMessages> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .read(chatControllerProvider)
            .getChatMessagesStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: messageData.timeSent,
                  type: messageData.type,
                );
              } else {
                return SenderMessageCard(
                  message: messageData.text,
                  date: messageData.timeSent,
                  type: messageData.type,
                );
              }
            },
          );
        });
  }
}
