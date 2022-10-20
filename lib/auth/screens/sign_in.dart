import 'package:chat_app/auth/screens/forgot_password.dart';
import 'package:chat_app/auth/screens/sign_up.dart';
import 'package:chat_app/auth/widgets/faded_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_in.dart';
import '../widgets/email_input.dart';
import '../widgets/google_button.dart';
import '../widgets/password_input.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragEnd: (DragEndDetails details) => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(title: const Text('Sign In')),
            resizeToAvoidBottomInset: false,
            body: Column(children: [
              const _EmailInput(),
              //const _UserIdInput(),
              const _PasswordInput(),
              const _ForgotPassword(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text('Sign up')),
                ],
              ),
              const Text('Or'),
              const _SignInButton(),
              //const _SwitchSignInMethodButton(),
              const GoogleButton()
            ])));
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          FadedOverlay.showLoading(context);
          SignInController.inst.validateEmailAndSignIn();
        },
        child: const Text('Sign In'));
  }
}

class _EmailInput extends EmailInput {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  RxString get email => SignInController.inst.email;

  @override
  Rx<String?> get errorText => SignInController.inst.emailErrorText;

  @override
  String? Function() get validator => SignInController.inst.emailValidator;
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              Get.to(const ForgotPassword());
            },
            child: const Text('Forgot password?')));
  }
}

class _PasswordInput extends PasswordInput {
  const _PasswordInput({Key? key}) : super(key: key);
  
  @override
  Rx<String?> get errorText => SignInController.inst.passwordErrorText;

  @override
  RxString get password => SignInController.inst.password;

  @override
  String? Function() get validator => SignInController.inst.passwordValidator;

  @override
  String? get hintText =>null;
}
// TODO
// styling widget
// class _SwitchSignInMethodButton extends StatelessWidget {
//   const _SwitchSignInMethodButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 240,
//       child: ElevatedButton(
//           onPressed: SignInController.inst.usingEmail.toggle,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Obx((() => FaIcon(SignInController.inst.usingEmail.value ? FontAwesomeIcons.mobileScreen : FontAwesomeIcons.envelope, size: 18))),
//               Container(
//                   height: 25,
//                   width: 1,
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                   )),
//               Obx(() => Text('Login with ${SignInController.inst.usingEmail.value ? 'phone number' : 'email'}'))
//             ],
//           )),
//     );
//   }
// }

// class _UserIdInput extends StatelessWidget {
//   const _UserIdInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 100,
//         child: Container(
//             padding: const EdgeInsets.only(top: 10),
//             alignment: Alignment.topCenter,
//             child: Obx(() => SignInController.inst.usingEmail.value ? const EmailInput() : const PhoneNumberInput())));
//   }
// }
