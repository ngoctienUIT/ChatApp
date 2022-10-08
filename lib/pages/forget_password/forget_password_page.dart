import 'package:chat_app/pages/login/custom_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

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
                  Image.asset("assets/chat.png", width: 60),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                        filled: true,
                        fillColor: const Color.fromRGBO(241, 242, 246, 1),
                        hintText: "Enter your email",
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  customButton(onPress: () {}, text: "Continue"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
