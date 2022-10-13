import 'package:flutter/material.dart';

// TODO:
// styling widget
// un-highlight border when keyboard get exited
// format input
// validate
class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final TextEditingController controller = TextEditingController();
  bool _passwordObscure = true;
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Password',
          border: const OutlineInputBorder(),
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
