import 'package:chat_app/chat/you_are_in.dart';
import 'package:chat_app/auth/services/facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../screens/create_password.dart';
import '../services/google_auth.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
          onPressed: () {
            // with this sign in method, user email will be verified along the way
            GoogleAuth.inst.signIn().then((credentials) async {
              await FbAuth.originalInst?.linkCredentials(credentials.user!.email!);
              if (credentials.additionalUserInfo!.isNewUser) {
                // suggest create a password for primary sign in method
                Get.offAll(()=>const CreatePassword());
              } else {
                Get.offAll(()=>const YouAreIn());
              }
            }).catchError((e) {
              //Get.snackbar('Google Sign In Error', e.toString());
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const FaIcon(FontAwesomeIcons.google, size: 18),
              Container(
                  height: 25,
                  width: 1,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  )),
              const Text('Sign in with Google')
            ],
          )),
    );
  }
}
