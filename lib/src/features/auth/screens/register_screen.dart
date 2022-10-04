import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/features/auth/widgets/bottom_next_button.dart';
import 'package:final_chat_app/src/features/auth/widgets/phone_number_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight / 10;
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Welcome!'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 38),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(20.0).copyWith(bottom: 25, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'What\'s your phone number?',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 32),
                            PhoneNumberForm(
                              formKey: formKey,
                              phoneNumberController: phoneNumberController,
                            ),
                          ],
                        ),
                      ),
                      BottomNextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppScreens.otpPath);
                          return FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
