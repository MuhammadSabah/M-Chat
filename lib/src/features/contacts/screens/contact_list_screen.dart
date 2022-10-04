import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/features/contacts/widgets/contact_card.dart';
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
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10)
                        .copyWith(bottom: 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                              ),
                            ),
                            hintText: 'Search in chat',
                            hintStyle: TextStyle(fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppScreens.chatPath);
                    },
                    child: const ContactCard(),
                  ),
                ],
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
