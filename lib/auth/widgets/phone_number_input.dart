import 'package:chat_app/auth/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO
// styling widget
class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.length == 10){
          SignInController.inst.phoneNumber(value);
        }
      },
      decoration: const InputDecoration(hintText: 'Phone number', border: OutlineInputBorder()),
      keyboardType: TextInputType.phone,
      autofillHints: const [AutofillHints.telephoneNumber],
      // 10 digits phone number constraint
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }
}