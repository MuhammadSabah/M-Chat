import 'dart:math';

import 'package:final_chat_app/common/utils.dart';
import 'package:final_chat_app/src/features/add_contact/controller/add_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContactScreen extends ConsumerStatefulWidget {
  const AddContactScreen({super.key});

  @override
  ConsumerState<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends ConsumerState<AddContactScreen> {
  void addContact(WidgetRef ref, Contact selectedContact, Color color,
      BuildContext context) {
    ref.read(addContactControllerProvider).addContact(context, selectedContact);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SafeArea(
        child: ref.watch(getContactProvider).when(
              data: (contactList) {
                if (contactList.isEmpty) {
                  return Container();
                }
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 2);
                  },
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    int randomInt = Random().nextInt(colors.length);
                    Color randomColor = colors[randomInt];
                    final contact = contactList[index];

                    return InkWell(
                      onTap: () =>
                          addContact(ref, contact, randomColor, context),
                      child: ListTile(
                        leading: Ink(
                          height: screenHeight / 16,
                          width: screenWidth / 8.5,
                          decoration: BoxDecoration(
                            color: randomColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: contact.photo == null
                              ? Center(
                                  child: Text(
                                    contact.displayName
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 26,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                        ),
                        subtitle: Text(contact.phones[0].number.toString()),
                        trailing: Icon(
                          Icons.add,
                          color: Colors.green.shade500,
                        ),
                        title: Text(
                          contact.displayName.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (((error, stackTrace) {
                return Center(
                  child: Text(
                    error.toString(),
                  ),
                );
              })),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
