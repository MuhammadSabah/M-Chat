import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({
    super.key,
    required this.formKey,
    required this.phoneNumberController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberController;

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  //
  Country? _country;

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
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    setState(() {
                      _country = country;
                    });
                    return FocusManager.instance.primaryFocus?.unfocus();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Text(
                        _country == null
                            ? ' '
                            : '+${_country!.phoneCode} ${_country!.flagEmoji}',
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
            hintText: 'Phone number',
          ),
        ),
      ),
    );
  }
}
