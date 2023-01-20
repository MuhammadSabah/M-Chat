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
    image = await pickImageFromGallery() ?? File('assets/default_image.jpg');

    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    print("NAME: " + name);
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirestore(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 45),
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
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const CircleAvatar(
                                          radius: 64,
                                          backgroundImage: NetworkImage(
                                              'https://images.unsplash.com/photo-1661586762551-b595e65388ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 64,
                                          backgroundImage: FileImage(image!),
                                        ),
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
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty || value == ' ') {
                                    return 'Name required';
                                  }
                                },
                                controller: nameController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your name'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    BottomNextButton(
                      onPressed: storeUserData,
                      text: 'Done',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
