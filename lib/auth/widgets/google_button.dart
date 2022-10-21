import 'package:chat_app/auth/screens/your_are_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../services/services.dart';

// TODO
// call firebase auth API
class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
          onPressed: () async {
            await GoogleAuth.inst.signIn();
            Get.offAll(const YouAreIn());
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
