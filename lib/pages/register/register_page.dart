import 'package:chat_app/pages/login/custom_button.dart';
import 'package:chat_app/pages/login/custom_button_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                  Image.asset("assets/chat.png", width: 60),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      border: UnderlineInputBorder(),
                      label: Text("Full Name", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      border: UnderlineInputBorder(),
                      label: Text("Email", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.6),
                      ),
                      border: const UnderlineInputBorder(),
                      label: const Text(
                        "Password",
                        style: TextStyle(fontSize: 16),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          check
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => check = !check);
                        },
                      ),
                    ),
                    obscureText: check,
                  ),
                  const SizedBox(height: 50),
                  customButton(onPress: () {}, text: "Sign up"),
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
                          Navigator.pushReplacementNamed(context, '/login');
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
                  const SizedBox(height: 20),
                  customButtonLogin(
                    onPress: () {},
                    icon: FontAwesomeIcons.facebookF,
                    text: "Sign Up with Facebook",
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 10),
                  customButtonLogin(
                    onPress: () {},
                    icon: FontAwesomeIcons.google,
                    text: "Sign Up with Google",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
