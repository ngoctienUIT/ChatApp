import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/forget_password/forget_password_page.dart';
import 'package:chat_app/pages/home/home_page.dart';
import 'package:chat_app/pages/login/login_page.dart';
import 'package:chat_app/pages/onboarding/onboarding_page.dart';
import 'package:chat_app/pages/register/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/home',
      routes: {
        '/': (context) => const OnBoardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot': (context) => const ForgetPasswordPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
