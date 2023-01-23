import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/common/firebase_storage_repository.dart';
import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

//
class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data() as Map<String, dynamic>);
    }
    return user;
  }

  //
  void signInWithPhone(BuildContext context, String phoneNo) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushNamed(
            context,
            AppScreens.otpPath,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        '❌',
        e.message ?? 'Some error occurred!',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: Colors.black,
      );
    }
  }

  // OTP Verification:
  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppScreens.userInformationPath,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        '❌',
        e.message ?? 'Some error occurred!',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: Colors.black,
      );
    }
  }

  // User data
  void saveUserDataToFirestore({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    String uid = auth.currentUser!.uid;
    String photoUrl =
        'https://images.unsplash.com/photo-1661586762551-b595e65388ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60';

    if (profilePic != null) {
      photoUrl = await ref
          .read(firebaseStorageRepositoryProvider)
          .storeFileToFirebase('profilePicture$uid', profilePic);
    }

    UserModel user = UserModel(
      name: name,
      uid: uid,
      profilePic: photoUrl,
      isOnline: true,
      phoneNumber: auth.currentUser!.phoneNumber!,
      groupId: [],
    );

    await firestore.collection('users').doc(uid).set(user.toMap());
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, AppScreens.home, (route) => false);
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void storeUserState(bool isOnline) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }

  void logout() async {
    await auth.signOut();
  }
}
