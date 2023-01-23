import 'package:final_chat_app/src/features/auth/repository/auth_repository.dart';
import 'package:final_chat_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});
//
final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    ref: ref,
    authRepository: authRepository,
  );
});

//
class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNo) {
    authRepository.signInWithPhone(context, phoneNo);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirestore(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirestore(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> getUserDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    return authRepository.storeUserState(isOnline);
  }

  void logout() async {
    authRepository.logout();
  }
}
