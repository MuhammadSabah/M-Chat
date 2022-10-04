import 'package:final_chat_app/core/app_screens.dart';
import 'package:final_chat_app/src/features/auth/widgets/bottom_next_button.dart';
import 'package:final_chat_app/src/features/auth/widgets/otp_form.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Verification code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text('We have sent the code verification to'),
                const SizedBox(
                  height: 16,
                ),
                OTPForm(otpFormKey: otpFormKey),
                const Spacer(),
                BottomNextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppScreens.home);
                    return FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
