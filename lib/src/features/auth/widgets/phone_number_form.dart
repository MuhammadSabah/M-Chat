import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneNumberForm extends StatefulWidget {
  PhoneNumberForm({
    super.key,
    required this.formKey,
    required this.phoneNumberController,
    required this.country,
    required this.onTap,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberController;
  Country? country;
  Function()? onTap;

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  //

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextFormField(
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Phone number required';
            }
            if (widget.country == null) {
              return 'Country code required';
            }
            return null;
          },
          style: Theme.of(context).textTheme.bodyText1,
          controller: widget.phoneNumberController,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          autofocus: false,
          autocorrect: false,
          keyboardType: TextInputType.number,
          obscureText: false,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Text(
                        widget.country == null
                            ? ' '
                            : '+${widget.country!.phoneCode} ${widget.country!.flagEmoji}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            counterText: ' ',
            filled: true,
            hintText: widget.country?.example,
          ),
        ),
      ),
    );
  }
}
