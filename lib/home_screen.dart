import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/contacts/screens/contact_list_screen.dart';
import 'package:final_chat_app/src/features/group/screens/group_list_screen.dart';
import 'package:final_chat_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key, this.user});
  UserModel? user;
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  int tabIndex = 0;
  double? iconSize = 28;
  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  List<Widget> pages = [
     ContactListScreen(),
    const GroupListScreen(),
  ];

  //
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        height: 65,
        onDestinationSelected: (int index) {
          setState(() {
            tabIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: iconSize! - 2.0,
            ),
            selectedIcon: Icon(
              Icons.chat_bubble,
              size: iconSize! - 2.0,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.groups_outlined,
              size: iconSize,
            ),
            selectedIcon: Icon(
              Icons.groups,
              size: iconSize,
            ),
            label: 'Groups',
          ),
        ],
      ),
    );
  }
}
