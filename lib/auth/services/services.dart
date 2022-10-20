// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   static final AuthService _instance = AuthService._internal();
//   static AuthService get inst =>_instance;
//   AuthService._internal();

//   Future<void> signInWithPhoneNumber(String phoneNumber) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int? resendToken) {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   Future<void> signInWithEmail(String email, String password) async {
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//     print(credential);
//     print(FirebaseAuth.instance.currentUser);
//   }

//   Future<void> signUpWithEmailAndPassword(String email, String password) async {
//  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }
// }
