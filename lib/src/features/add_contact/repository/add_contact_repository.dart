import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final addContactRepositoryProvider = Provider((ref) {
  return AddContactRepository(
    firestore: FirebaseFirestore.instance,
  );
});

class AddContactRepository {
  final FirebaseFirestore firestore;

  AddContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void addContact(Contact selectedContact, BuildContext context) async {
    try {
      dynamic userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (dynamic document in userCollection.docs) {
        UserModel userData = UserModel.fromMap(document.data());
        String selectedPhoneNo =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNo == userData.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, AppScreens.chatPath, arguments: {
            'name': userData.name,
            'uid': userData.uid,
          });
        }
      }
      if (!isFound) {
        Get.snackbar(
          '❌',
          "This number does not exist on this app",
          snackPosition: SnackPosition.TOP,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          colorText: Colors.black,
        );
      }
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
