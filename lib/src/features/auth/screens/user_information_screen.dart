import 'dart:io';
import 'package:final_chat_app/common/utils.dart';
import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/auth/widgets/bottom_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirestore(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            image == null
                                ? const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1661586762551-b595e65388ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage: FileImage(image!),
                                  ),
                            Positioned(
                              bottom: 10,
                              left: 80,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                child: IconButton(
                                  color: Colors.white,
                                  iconSize: 16,
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: TextField(
                            // controller: nameController,
                            decoration:
                                InputDecoration(hintText: 'Enter your name'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // IconButton(
                //   onPressed: storeUserData,
                //   icon: const Icon(Icons.done),
                // ),
                BottomNextButton(onPressed: storeUserData,text: 'Done',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
