import 'package:final_chat_app/src/features/add_contact/repository/add_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:riverpod/riverpod.dart';

final getContactProvider = FutureProvider((ref) {
  final addContactRepository = ref.watch(addContactRepositoryProvider);
  return addContactRepository.getContacts();
});

final addContactControllerProvider = Provider((ref) {
  final addContactRepository = ref.watch(addContactRepositoryProvider);
  return AddContactController(
    ref: ref,
    addContactRepository: addContactRepository,
  );
});

class AddContactController {
  final ProviderRef ref;
  final AddContactRepository addContactRepository;
  AddContactController({
    required this.ref,
    required this.addContactRepository,
  });

  void addContact(BuildContext context, Contact selectedContact) {
    addContactRepository.addContact(selectedContact, context);
  }
}
