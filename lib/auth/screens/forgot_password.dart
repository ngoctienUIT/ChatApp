import 'package:chat_app/auth/widgets/custom_button.dart';
import 'package:chat_app/auth/widgets/email_input.dart';
import 'package:flutter/material.dart';

// TODO: you know what to do
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 30),
                  Image.asset("assets/images/chat.png", width: 60),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: Text(
                      "No problem. Enter the email address you used to register your account and we'll send you a reset link",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: EmailInput()),
                  const SizedBox(height: 50),
                  CustomButton(onPress: () {}, text: "Continue")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
