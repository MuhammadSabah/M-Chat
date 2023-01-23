import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


   List<Color> colors = [
    Colors.green.shade400,
    Colors.grey.shade400,
    Colors.red.shade400,
    Colors.blue.shade400,
    Colors.blueAccent.shade400,
    Colors.pink.shade400,
    Colors.purple.shade400,
    Colors.amber.shade400,
    Colors.yellowAccent.shade400,
    Colors.orange.shade400,
    Colors.orangeAccent.shade400,
  ];

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
