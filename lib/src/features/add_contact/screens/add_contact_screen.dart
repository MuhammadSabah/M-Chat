import 'package:flutter/material.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

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
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                leading: Ink(
                  height: screenHeight / 16,
                  width: screenWidth / 8.5,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'M',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
                trailing: const Icon(Icons.add),
                title: const Text('ContactName'),
              ),
            );
          },
        ),
      ),
    );
  }
}
