import 'package:final_chat_app/core/app_pages.dart';
import 'package:final_chat_app/main.dart';
import 'package:final_chat_app/src/features/chat/screens/chat_screen.dart';
import 'package:final_chat_app/src/features/contacts/screens/contact_list_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppScreens.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppScreens.contactPath:
        return MaterialPageRoute(
          builder: (context) => const ContactListScreen(),
        );
      case AppScreens.chatPath:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
