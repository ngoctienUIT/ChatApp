import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YouAreIn extends StatelessWidget {
  const YouAreIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Text(FirebaseAuth.instance.currentUser.toString()),
      ElevatedButton(onPressed: (){}, child: const Text('Sign out'))
    ],));
  }
}