import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/auth/widgets/bottom_next_button.dart';
import 'package:final_chat_app/src/features/auth/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class OTPScreen extends ConsumerWidget {
  OTPScreen({super.key, required this.verificationID});

  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final String verificationID;

  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  final TextEditingController otp5 = TextEditingController();
  final TextEditingController otp6 = TextEditingController();

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationID, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'We have sent the code verification',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 28,
                ),
                OTPForm(
                  otpFormKey: otpFormKey,
                  otp1: otp1,
                  otp2: otp2,
                  otp3: otp3,
                  otp4: otp4,
                  otp5: otp5,
                  otp6: otp6,
                ),
                const Spacer(),
                BottomNextButton(
                  text: 'Next',
                  onPressed: () {
                    String otpValue = otp1.text +
                        otp2.text +
                        otp3.text +
                        otp4.text +
                        otp5.text +
                        otp6.text;

                    verifyOTP(ref, context, otpValue);
                    FocusManager.instance.primaryFocus?.unfocus();
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
