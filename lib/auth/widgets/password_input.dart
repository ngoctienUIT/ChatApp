import 'package:flutter/material.dart';

import '../controllers/controllers.dart';

// TODO:
// styling widget
// format input
// validate
class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: SignInController.inst.password,
      decoration: InputDecoration(
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
    );
  }
}
