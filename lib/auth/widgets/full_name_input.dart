import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';

// TODO
// styling widget
class FullNameInput extends StatefulWidget {
  const FullNameInput({Key? key}) : super(key: key);

  @override
  State<FullNameInput> createState() => _FullNameInputState();
}

class _FullNameInputState extends State<FullNameInput> {
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
          SignInController.inst.nameErrorText.value = null;

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
        child: Obx(
          () => TextFormField(
            // Cant put setState right here
            // when user not input: no error
            // when user input and then leave the field empty: no error
            // when user input and then leave the field with invalid email: error
            validator: (value) {
              if (!isOnFocus && value!.isNotEmpty) {
                return SignInController.inst.nameValidator();
              }
              return null;
            },
            onChanged: SignInController.inst.name,
            decoration: InputDecoration(
              errorText: SignInController.inst.nameErrorText.value,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.6),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.6),
              ),
              border: const UnderlineInputBorder(),
              label: const Text("Full Name", style: TextStyle(fontSize: 16)),
            ),
            autofillHints: const [AutofillHints.name],
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          ),
        ),
      ),
    );
  }
}
