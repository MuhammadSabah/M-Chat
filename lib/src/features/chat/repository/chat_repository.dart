import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/common/firebase_storage_repository.dart';
import 'package:final_chat_app/common/utils.dart';
import 'package:final_chat_app/src/models/chat_contact.dart';
import 'package:final_chat_app/src/models/message.dart';
import 'package:final_chat_app/src/models/message_enum.dart';
import 'package:final_chat_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap(
      (event) async {
        List<ChatContact> contacts = [];
        for (dynamic document in event.docs) {
          ChatContact chatContact = ChatContact.fromMap(document.data());
          dynamic userData = await firestore
              .collection('users')
              .doc(chatContact.contactId)
              .get();
          dynamic user = UserModel.fromMap(userData.data());
          contacts.add(
            ChatContact(
              name: user.name,
              profilePic: user.profilePic,
              contactId: chatContact.contactId,
              timeSent: chatContact.timeSent,
              lastMessage: chatContact.lastMessage,
              color: chatContact.color,
            ),
          );
        }
        return contacts;
      },
    );
  }

  Stream<List<Message>> getChatMessagesStream(String receiverUserId) {
    //

    //
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (dynamic doc in event.docs) {
        messages.add(
          Message.fromMap(doc.data()),
        );
      }
      return messages;
    });
  }

  void saveDataToContactsSubCollection({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String text,
    required DateTime timeSent,
    required String receiverUserId,
  }) async {
    //
    int randomInt = Random().nextInt(colors.length);
    Color randomColor = colors[randomInt];
    //
    var receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
      color: randomColor,
    );
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(senderUserData.uid)
        .set(receiverChatContact.toMap());
    //
    var senderChatContact = ChatContact(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
      color: randomColor,
    );
    await firestore
        .collection('users')
        .doc(senderUserData.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(senderChatContact.toMap());
  }

  void saveMessageToMessageSubCollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required receiverUserName,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
    //
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      var userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();
      UserModel receiverUserData = UserModel.fromMap(userDataMap.data()!);

      //
      saveDataToContactsSubCollection(
        senderUserData: senderUser,
        receiverUserData: receiverUserData,
        text: text,
        timeSent: timeSent,
        receiverUserId: receiverUserId,
      );
      var messageId = const Uuid().v1();
      //
      saveMessageToMessageSubCollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        receiverUserName: receiverUserData.name,
        username: senderUser.name,
      );
    } catch (e) {
      Get.snackbar(
        '❌',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: Colors.black,
      );
    }
  }

  void sendFileImage({
    required File file,
    required receiverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      String messageId = const Uuid().v1();
      String imageUrl =
          await ref.read(firebaseStorageRepositoryProvider).storeFileToFirebase(
                'chat/${messageEnum.type}/${senderUserData.uid}/$receiverUserId/$messageId',
                file,
              );
      DocumentSnapshot<Map<String, dynamic>> userData =
          await firestore.collection('users').doc(receiverUserId).get();
      UserModel receiverUserData = UserModel.fromMap(userData.data()!);
      //
      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🔉 Audio';
          break;
        default:
          contactMsg = '';
      }
      //
      saveDataToContactsSubCollection(
        senderUserData: senderUserData,
        receiverUserData: receiverUserData,
        text: contactMsg,
        timeSent: timeSent,
        receiverUserId: receiverUserId,
      );
      //
      saveMessageToMessageSubCollection(
        receiverUserId: receiverUserId,
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        receiverUserName: receiverUserData.name,
        messageType: messageEnum,
      );
    } catch (e) {
      Get.snackbar(
        '❌',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: Colors.black,
      );
    }
  }
}
