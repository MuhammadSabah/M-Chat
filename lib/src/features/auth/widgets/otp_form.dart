import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OTPForm extends StatelessWidget {
  OTPForm({
    super.key,
    required this.otpFormKey,
    required this.otp1,
    required this.otp2,
    required this.otp3,
    required this.otp4,
    required this.otp5,
    required this.otp6,
  });
  Color textFieldFillColor = Colors.grey.shade100;
  OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade100,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  );
  final GlobalKey<FormState> otpFormKey;
  final TextEditingController otp1;
  final TextEditingController otp2;
  final TextEditingController otp3;
  final TextEditingController otp4;
  final TextEditingController otp5;
  final TextEditingController otp6;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: otpFormKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp1,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin1) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp2,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin2) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp3,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin3) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp4,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin4) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp5,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin5) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 56,
            child: TextFormField(
              controller: otp6,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                hintText: '0',
                border: fieldBorder,
              ),
              onSaved: (pin5) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
