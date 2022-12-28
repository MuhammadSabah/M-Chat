import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// void showCustomSnackbar({
//   required BuildContext context,
//   required String content,
// }) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(content),
//     ),
//   );
// }

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
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
  return image;
}

Future<File?> pickVideoFromGallery() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
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
  return video;
}
