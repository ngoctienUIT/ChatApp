import 'package:chat_app/auth/screens/sign_in.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth/screens/splash.dart';
import 'auth/screens/your_are_in.dart';
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
  print('currentUser:');
  print(FirebaseAuth.instance.currentUser);
  runApp(const GetMaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Splash();
          }
          final user = snapshot.data;
          if (user != null) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              return const YouAreIn();
            } else {
              FirebaseAuth.instance.signOut();
              return const SignIn();
            }
          } else {
            return const SignIn();
          }
        });
  }
}
