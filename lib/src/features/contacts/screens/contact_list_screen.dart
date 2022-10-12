import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/features/contacts/widgets/contact_card.dart';
import 'package:final_chat_app/src/features/contacts/widgets/search_field.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10)
                        .copyWith(bottom: 18),
                child: SearchField(
                  hintText: 'Search in chat',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0)
                    .copyWith(bottom: 4),
                child: Text('Chats'),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppScreens.chatPath);
                      },
                      child: const ContactCard(),
                    );
                  },
                ),
              ),
            ],
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
