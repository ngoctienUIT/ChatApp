import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';

// TODO
// styling widget
class EmailInput extends StatefulWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
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
            // reset error text
            SignInController.inst.emailErrorText.value =null;

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
            child: Obx(() => TextFormField(
              // Cant put setState right here
              // when user not input: no error
              // when user input and then leave the field empty: no error
              // when user input and then leave the field with invalid email: error
              validator: (value) {
                if (!isOnFocus && value!.isNotEmpty) {
                  return SignInController.inst.emailValidator();
                }
                return null;
              },
              onChanged: SignInController.inst.email,
              decoration: InputDecoration(
                  errorText: SignInController.inst.emailErrorText.value,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            ))));
  }
}