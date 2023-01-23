import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/home_screen.dart';
import 'package:final_chat_app/src/features/add_contact/screens/add_contact_screen.dart';
import 'package:final_chat_app/src/features/auth/screens/otp_screen.dart';
import 'package:final_chat_app/src/features/auth/screens/register_screen.dart';
import 'package:final_chat_app/src/features/auth/screens/user_information_screen.dart';
import 'package:final_chat_app/src/features/chat/screens/chat_screen.dart';
import 'package:final_chat_app/src/features/contacts/screens/contact_list_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppScreens.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case AppScreens.contactPath:
        return MaterialPageRoute(
          builder: (context) => ContactListScreen(),
        );
      case AppScreens.chatPath:
        final args = settings.arguments as Map<String, dynamic>;
        final name = args['name'];
        final uid = args['uid'];
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            name: name,
            uid: uid,
          ),
        );
      case AppScreens.registerPath:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case AppScreens.otpPath:
        final verifictionID = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => OTPScreen(verificationID: verifictionID),
        );
      case AppScreens.selectContactPath:
        return MaterialPageRoute(
          builder: (context) => const AddContactScreen(),
        );
      case AppScreens.userInformationPath:
        return MaterialPageRoute(
          builder: (context) => const UserInformationScreen(),
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
