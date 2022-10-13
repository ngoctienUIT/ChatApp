import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO
// styling widget
// un-highlight border when keyboard get exited
// validate
class EmailInput extends StatelessWidget {
  EmailInput({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }
}

//SignInMethod _signInMethod;
// final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

// ElevatedButton(
//     onPressed: () {
//       // validate form
//       // check email
//       // if (!_emailRegex.hasMatch(_userIdController.text)) {
//       //   // make alert on user id field