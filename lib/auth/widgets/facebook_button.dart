import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../screens/create_password.dart';
import '../screens/your_are_in.dart';
import '../services/facebook_auth.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade800)),
          onPressed: () {
            FbAuth.inst.signIn().then((credentials) {
              if (credentials.user!.metadata.lastSignInTime!.difference(credentials.user!.metadata.creationTime!).inMilliseconds < 1000) {
                // suggest create a password for primary sign in method
                Get.offAll(const CreatePassword());
              } else {
                Get.offAll(const YouAreIn());
              }
            }).catchError((e) {
              //Get.snackbar('Facabook Sign In Error', e.toString());
              print(e);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const FaIcon(FontAwesomeIcons.facebook, size: 18),
              Container(
                  height: 25,
                  width: 1,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  )),
              const Text('Sign in with Facebook')
            ],
          )),
    );
  }
}
