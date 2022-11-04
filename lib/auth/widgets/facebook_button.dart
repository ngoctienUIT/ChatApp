import 'package:chat_app/auth/screens/email_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../screens/your_are_in.dart';
import '../services/facebook_auth.dart';

// email verified?
// yes: (of course this is not the first time signing in)
// 	YouAreIn
// no:
// 	first time signin in?
// 	yes:
// 		send verification mail
// 		Dialog: pls verify your email, make sure they verify their email before moving on (continue: update user, quit: sign out)
// 		Prompt user to provide a password for primary sign in method, they can skip and set password in setting
// 	no:
// 		Dialog: pls verify your email, make sure they verify their email before moving on (continue: update user, quit: sign out)
// 		YouAreIn

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade800)),
          onPressed: () {
            // with this sign in method, user email may not verifed, especially the first time sign up to the system
            FbAuth.inst.signIn().then((credentials) async {
              if (credentials == null) return;
              if (credentials.user!.emailVerified) {
                Get.offAll(const YouAreIn());
              } else {
                if (credentials.additionalUserInfo!.isNewUser) {
                  await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Get.offAll(const EmailVerification(
                    isNewUser: true,
                  ));
                } else {
                  Get.offAll(const EmailVerification());
                }
              }
            })
            .catchError((e) {
              Get.snackbar('Facabook Sign In Error', e.toString());
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

// Future<void> _promptUserToVerifyEmail() async {
//   await Get.defaultDialog(
//       barrierDismissible: false,
//       title: 'Verify your email',
//       content: Column(
//         children: const [Text('Please check your mail box to verify your email'), _NeedHelpButton()],
//       ),
//       confirm: ElevatedButton(onPressed: () {}, child: const Text('Done, take me in')));
// }

// class _NeedHelpButton extends StatelessWidget {
//   const _NeedHelpButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         child: const Text('Need help?'),
//         onPressed: () {
//           Get.back();
//           Get.defaultDialog(
//             barrierDismissible: false,
//             title: 'Support',
//             content: Column(children: const [
//               Text('You don\'t see the mail? Please check other places such as spam box'),
//               Text('Or'),
//               SendVerificationLinkButton()
//             ]),
//           );
//         },
//       ),
//     );
//   }
// }
