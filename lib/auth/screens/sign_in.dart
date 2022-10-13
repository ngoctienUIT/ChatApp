import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';
import '../controllers/controllers.dart';
import '../widgets/email_input.dart';
import '../widgets/google_button.dart';
import '../widgets/password_input.dart';
import '../widgets/phone_number_input.dart';

// TODO
// styling widget
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          const _UserIdInput(),
          const PasswordTextField(),
          Container(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot password?'))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              TextButton(onPressed: () {}, child: const Text('Sign up')),
            ],
          ),
          const Text('Or'),
          const _SignInButton(),
          const _SwitchSignInMethodButton(),
          const GoogleButton()
        ]));
  }
}

// TODO
// styling widget
class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text('Sign In'));
  }
}

// TODO
// styling widget
class _SwitchSignInMethodButton extends StatelessWidget {
  const _SwitchSignInMethodButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
          onPressed: SignInController.inst.usingEmail.toggle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx((() => FaIcon(SignInController.inst.usingEmail.value ? FontAwesomeIcons.mobileScreen : FontAwesomeIcons.envelope, size: 18))),
              Container(
                  height: 25,
                  width: 1,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  )),
              Obx(() => Text('Login with ${SignInController.inst.usingEmail.value ? 'phone number' : 'email'}'))
            ],
          )),
    );
  }
}

class _UserIdInput extends StatelessWidget {
  const _UserIdInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SignInController.inst.usingEmail.value ? EmailInput() : PhoneNumberInput());
  }
}