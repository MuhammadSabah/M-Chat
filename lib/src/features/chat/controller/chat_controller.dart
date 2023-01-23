import 'dart:io';

import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/chat/repository/chat_repository.dart';
import 'package:final_chat_app/src/models/chat_contact.dart';
import 'package:final_chat_app/src/models/message.dart';
import 'package:final_chat_app/src/models/message_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider<ChatController>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> getChatMessagesStream(String receiverUserId) {
    return chatRepository.getChatMessagesStream(receiverUserId);
  }

  void sendTextMessage(
    String text,
    String receiverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!,
          ),
        );
  }

  void sentFileMessage({
    required File file,
    required receiverUserId,
    required MessageEnum messageEnum,
  }) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileImage(
            file: file,
            receiverUserId: receiverUserId,
            senderUserData: value!,
            messageEnum: messageEnum,
            ref: ref,
          ),
        );
  }
}
