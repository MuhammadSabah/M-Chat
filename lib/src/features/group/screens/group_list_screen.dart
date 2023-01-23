import 'package:final_chat_app/src/features/contacts/widgets/contact_card.dart';
import 'package:final_chat_app/src/features/contacts/widgets/search_field.dart';
import 'package:flutter/material.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10)
                      .copyWith(bottom: 18),
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0)
                  .copyWith(bottom: 4),
              child: Text('Groups'),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {},
        tooltip: 'New group',
        label: const Text('New group'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
