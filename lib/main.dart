import 'package:chat_app/auth/screens/not_verified.dart';
import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'chat/you_are_in.dart';

//import 'auth/services/dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get any initial links
  //await DynamicLinks.inst.initialLink;

  // Transparent status bar, dont need to use SafeArea
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // print('currentUser:');
  // print(FirebaseAuth.instance.currentUser);
  runApp(const GetMaterialApp(debugShowCheckedModeBanner: false, home: _Home()));
}

class _Home extends StatelessWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) return const SignIn();

    if (!user.emailVerified) return const NotVerified();

    return const YouAreIn();
  }
}
