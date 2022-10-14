import 'package:chat_app/auth/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO
// styling widget
class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({Key? key}) : super(key: key);

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  bool isOnFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
        onFocusChange: (value) {
          setState(() {
            isOnFocus = !isOnFocus;
          });
        },
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              // On end editing: which happen when user un focus the field
              validator: (value) {
                if ((!isOnFocus) && (value!.length < 10)) {
                  return 'Phone number must be 10 digits';
                }
                return null;
              },
              decoration: const InputDecoration(
                  //hintText: 'Phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_android),
                  labelText: 'Phone number'),
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              // 10 digits phone number constraint
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            )));
  }
}