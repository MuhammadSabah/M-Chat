import 'package:country_picker/country_picker.dart';
import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/auth/widgets/bottom_next_button.dart';
import 'package:final_chat_app/src/features/auth/widgets/phone_number_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Country? _country;

  void sendPhoneNumber() {
    debugPrint(phoneNumberController.text);
    String phoneNumber = phoneNumberController.text.trim();
    if (_country != null && phoneNumberController.text.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${_country!.phoneCode}$phoneNumber');
    } else {
      Get.snackbar(
        '❌',
        'Field is empty',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: Colors.black,
      );
    }
  }

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
          automaticallyImplyLeading: false,
          toolbarHeight: appBarHeight,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Column(
            children: const [
              Text('Welcome!'),
            ],
          ),
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
                              country: _country,
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  onSelect: (Country country) {
                                    setState(() {
                                      _country = country;
                                    });
                                    return FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      BottomNextButton(
                        text: 'Next',
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              _country != null) {
                            sendPhoneNumber();
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
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
