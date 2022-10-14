import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//SignInMethod _signInMethod;
// final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

// ElevatedButton(
//     onPressed: () {
//       // validate form
//       // check email
//       // if (!_emailRegex.hasMatch(_userIdController.text)) {
//       //   // make alert on user id field

// TODO
// styling widget
// validate
class EmailInput extends StatefulWidget {
  const EmailInput({Key? key}) : super(key: key);
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
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
                if ((!isOnFocus) && (!EmailInput.emailRegex.hasMatch(value!))) {
                  // validate here
                  return 'Invalid email!';
                }

                return null;
              },
              decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.email), labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            )));
  }
}