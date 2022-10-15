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
                if (!isOnFocus && !EmailInput.emailRegex.hasMatch(value!)) {
                  return 'Invalid email!';
                }
                return null;
              },
              onChanged: SignInController.inst.email,
              decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.email), labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            )));
  }
}