import 'package:chat_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../screens/sign_in.dart';

// TODO: FIRST SIGNING IN, MAYBE USER EMAIL IS NOT VERIFIED,
// CASE 0: ALL CREDENTIALS SYNCHRONIZED, NOTHING TO WORRIED ABOUT
// CASE 1: user sign in with fb for the first time
// CASE 2: ACCOUNT EXISTS WITH DIFFERENT CREDENTIALS
class FbAuth {
  static FbAuth? _inst;
  FbAuth._internal();
  static FbAuth get inst {
    _inst ??= FbAuth._internal();
    return _inst!;
  }

  static FbAuth? get originalInst => _inst;

  Future<UserCredential> signIn() async {
    // Get Login Result from Facebook
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential? credentials;

    try {
      credentials = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          //Thrown if there already exists an account with the email address asserted by the credential.
          //Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers.
          //Once the user is signed in, the original credential can be linked to the user with [linkWithCredential].
          var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail((await FacebookAuth.instance.getUserData())['email'].toString());
          print(methods);
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
    await FacebookAuth.instance.logOut();
  }
}
