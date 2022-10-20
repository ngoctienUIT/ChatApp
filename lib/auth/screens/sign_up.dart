import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up.dart';
import '../widgets/email_input.dart';
import '../widgets/faded_overlay.dart';
import '../widgets/name_input.dart';
import '../widgets/password_input.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragEnd: (DragEndDetails details) => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
            ),
            resizeToAvoidBottomInset: false,
            body: Column(children: const [NameInput(), _EmailInput(), _PasswordInput(), _SignUpButton()])));
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          FadedOverlay.showLoading(context);
          SignUpController.inst.validateAndSignUp();
        },
        child: const Text('Sign Up'));
  }
}

class _EmailInput extends EmailInput {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  RxString get email => SignUpController.inst.email;

  @override
  Rx<String?> get errorText => SignUpController.inst.emailErrorText;

  @override
  String? Function() get validator => SignUpController.inst.emailValidator;
}

class _PasswordInput extends PasswordInput {
  const _PasswordInput({Key? key}) : super(key: key);
  @override
  Rx<String?> get errorText => SignUpController.inst.passwordErrorText;

  @override
  RxString get password => SignUpController.inst.password;

  @override
  String? Function() get validator => SignUpController.inst.passwordValidator;

  @override
  String? get hintText => SignUpController.inst.passwordHint;
}