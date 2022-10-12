import 'package:flutter/material.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // InkWell(
          //   onTap: () {
          // Navigator.pushNamed(context, AppScreens.chatPath);
          //   },
          // child: const ContactCard(),
          // ),
        ],
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
