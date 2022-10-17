import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

// TODO:
// styling widget
class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  // Not focus for default, if widget is settled to be auto focused, this init will make no sense
  bool isOnFocus = false;
  bool _passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
        onFocusChange: (value) {
          // focus: true
          // not focus on any widget: true
          // focus on other widget: false
          if (value) {
            // reset error text
            SignInController.inst.passwordErrorText.value = null;

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
                  onChanged: SignInController.inst.password,
                  decoration: InputDecoration(
                      errorText: SignInController.inst.passwordErrorText.value,
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () => setState(() {
                                _passwordObscure = !_passwordObscure;
                              }),
                          icon: Icon(_passwordObscure ? Icons.visibility : Icons.visibility_off))),
                  obscureText: _passwordObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                ))));
  }
}
