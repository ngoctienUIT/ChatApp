import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../widgets/faded_overlay.dart';

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
              FadedOverlay.showLoading(context);
              SignInController.inst.signOut();
            },
            child: const Text('Sign out'))
      ],
    ));
  }
}
