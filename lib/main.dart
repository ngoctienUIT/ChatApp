import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth/screens/your_are_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Transparent status bar, dont need to use SafeArea
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  print('currentUser:');
  print(FirebaseAuth.instance.currentUser );
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false, home: (FirebaseAuth.instance.currentUser != null) ? const YouAreIn() : const SignIn()));
}