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
  // Not focus for default, if widget is settled to be auto focused, this init will make no sense
  bool isOnFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
        onFocusChange: (value) {
          // focus: true
          // not focus on any widget: true
          // focus on other widget: false
          if (value) {
            setState(() {
              isOnFocus = !isOnFocus;
            });
          } else {
            setState(() {
              isOnFocus = false;
            });
          }
        },
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              // On end editing: which happen when user un focus the field
              // On end editing: set state if value is valid
              // Cant put setState right here
              validator: (value) {
                if (!isOnFocus && value!.length < 10) {
                  return 'Phone number must be 10 digits';
                }
                return null;
              },
              onChanged: SignInController.inst.phoneNumber,
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
