import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/controllers.dart';

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
              // On end editing: set state if value is valid
              validator: (value) {
                if (!isOnFocus) {
                  if (!EmailInput.emailRegex.hasMatch(value!)) {
                    return 'Invalid email!';
                  }
                  SignInController.inst.email(value);
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