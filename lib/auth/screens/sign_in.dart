import 'package:chat_app/auth/screens/forgot_password.dart';
import 'package:chat_app/auth/screens/sign_up.dart';
import 'package:chat_app/auth/widgets/faded_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../widgets/email_input.dart';
import '../widgets/google_button.dart';
import '../widgets/password_input.dart';

// TODO
// styling widget
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 30),
                Image.asset("assets/images/chat.png", width: 60),
                const SizedBox(height: 30),
                const EmailInput(),
                //const _UserIdInput(),
                const SizedBox(height: 20),
                const PasswordInput(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(const ForgotPassword());
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const _SignInButton(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Or",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 10),
                //const _SwitchSignInMethodButton(),
                const GoogleButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO
// styling widget
class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(27, 150, 200, 1),
            Color.fromRGBO(15, 202, 177, 1)
          ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ]),
      child: ElevatedButton(
        onPressed: () {
          FadedOverlay.showLoading(context);
          SignInController.inst.validateEmailAndSignIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
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
