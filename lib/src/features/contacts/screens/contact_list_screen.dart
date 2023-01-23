import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/features/chat/repository/chat_repository.dart';
import 'package:final_chat_app/src/features/contacts/widgets/contact_card.dart';
import 'package:final_chat_app/src/features/contacts/widgets/search_field.dart';
import 'package:final_chat_app/src/models/chat_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListScreen extends ConsumerWidget {
  const ContactListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder<List<ChatContact>>(
            stream: ref.watch(chatRepositoryProvider).getChatContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10,
                    ).copyWith(bottom: 18),
                    child: const SizedBox(
                      child: TopSearchField(
                        hintText: 'Search in chat',
                        name: "Hama",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0)
                        .copyWith(bottom: 4),
                    child: const Text(
                      'Chats',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        ChatContact chatContactData = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppScreens.chatPath,
                              arguments: {
                                'name': chatContactData.name,
                                'uid': chatContactData.contactId,
                              },
                            );
                          },
                          child: ContactCard(
                            name: chatContactData.name,
                            uid: chatContactData.contactId,
                            cardColor:chatContactData.color,
                            // Color
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: null,
          onPressed: () {
            Navigator.pushNamed(context, AppScreens.selectContactPath);
          },
          tooltip: 'Add contact',
          label: const Text('Add Contact'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
