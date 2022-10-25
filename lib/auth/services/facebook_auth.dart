import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FbAuth {
  static FbAuth? _inst;
  FbAuth._internal();
  static FbAuth get inst {
    _inst ??= FbAuth._internal();
    return _inst!;
  }

  Future<UserCredential> signIn() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}
