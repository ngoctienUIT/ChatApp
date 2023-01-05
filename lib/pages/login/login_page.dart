import 'package:chat_app/controls/login_control.dart';
import 'package:chat_app/pages/login/custom_button.dart';
import 'package:chat_app/pages/login/custom_button_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool check = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Enter a valid password";
                      }
                      return null;
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot');
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  customButton(
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        bool result = await LoginControl.loginEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (result) {
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      }
                    },
                    text: "Sign in",
                  ),
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
                          Navigator.pushReplacementNamed(context, '/register');
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
                  const SizedBox(height: 20),
                  customButtonLogin(
                    onPress: () async {
                      bool result = await LoginControl.signInWithFacebook();
                      if (result) {
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    icon: FontAwesomeIcons.facebookF,
                    text: "Login with Facebook",
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 10),
                  customButtonLogin(
                    onPress: () async {
                      bool result = await LoginControl.signInWithGoogle();
                      if (result) {
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    icon: FontAwesomeIcons.google,
                    text: "Login with Google",
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
