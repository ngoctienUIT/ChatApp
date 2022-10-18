import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/auth/widgets/custom_button.dart';
import 'package:chat_app/auth/widgets/email_input.dart';
import 'package:chat_app/auth/widgets/full_name_input.dart';
import 'package:chat_app/auth/widgets/google_button.dart';
import 'package:chat_app/auth/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: you know what to do
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 30),
                Image.asset("assets/images/chat.png", width: 60),
                const SizedBox(height: 30),
                const FullNameInput(),
                const SizedBox(height: 20),
                const EmailInput(),
                const SizedBox(height: 20),
                const PasswordInput(),
                const SizedBox(height: 50),
                CustomButton(onPress: () {}, text: "Sign Up"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(const SignIn());
                      },
                      child: const Text(
                        "Sign in",
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
                const GoogleButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
