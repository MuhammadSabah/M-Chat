import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPForm extends StatelessWidget {
  OTPForm({
    super.key,
    required this.otpFormKey,
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
        ],
      ),
    );
  }
}
