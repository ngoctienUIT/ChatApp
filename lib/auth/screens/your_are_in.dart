import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// this widget is just for testing for signing in successfully
class YouAreIn extends StatelessWidget {
  const YouAreIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(FirebaseAuth.instance.currentUser.toString()),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((_) {
                Get.offAll(const SignIn());
              }).catchError((e) {
                announce(context, 'Sign out error', e.toString());
              });
            },
            child: const Text('Sign out'))
      ],
    ));
  }
}