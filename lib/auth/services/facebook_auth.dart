import 'package:chat_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../screens/sign_in.dart';

class FbAuth {
  static FbAuth? _inst;
  FbAuth._internal();
  static FbAuth get inst {
    _inst ??= FbAuth._internal();
    return _inst!;
  }

  static FbAuth? get originalInst => _inst;

  OAuthCredential? _facebookAuthCredential;

  Future<UserCredential> signIn() async {
    // Get Login Result from Facebook
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);

    // Create a credential from the access token
    _facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential? credentials;

    try {
      credentials = await FirebaseAuth.instance.signInWithCredential(_facebookAuthCredential!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          //Thrown if there already exists an account with the email address asserted by the credential.
          //Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers.
          //Once the user is signed in, the original credential can be linked to the user with [linkWithCredential].
          // var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail((await FacebookAuth.instance.getUserData())['email'].toString());
          // print(methods);
          await Get.defaultDialog(
              title: 'First time Facebook signing in',
              content: const Text('Please sign in with different method to link your Facebook credentials'),
              onConfirm: () async {
                Get.back();
              });

          break;
        default:
          throw Exception(e);
      }
    }

    print('credentials:');
    print(credentials);

    return credentials!;
  }

  Future<void> signInAfterVerification() async {}

  Future<void> signOut() async {
    _facebookAuthCredential = null;
    await FacebookAuth.instance.logOut();
  }

  Future<void> linkCredentials() async{
    if (_facebookAuthCredential != null) {
      await FirebaseAuth.instance.currentUser!.linkWithCredential(_facebookAuthCredential!);
    }
  }
}
