import 'package:chat_app/auth/screens/your_are_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';
import '../screens/sign_in.dart';
import '../widgets/faded_overlay.dart';

// TODO
// overrider: navigate back to prompt user to log out
// remember password
// start loading should be placed here
class SignInController extends GetxController {
  static final SignInController _inst = Get.put(SignInController());
  static SignInController get inst => _inst;

  //var usingEmail = true.obs;

  //#region EMAIL
  final email = ''.obs;

  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String? emailValidator() {
    if (!emailRegex.hasMatch(email.value)) {
      return 'Please enter a valid email!';
    }

    return null;
  }

  var emailErrorText = Rx<String?>(null);
  //#endregion

  //#region PHONE NUMBER
  // var phoneNumber = ''.obs;
  // RegExp phoneRegex = RegExp(r'^[0-9]{10}');
  // String? phoneNumberValidator() {
  //   if (!phoneRegex.hasMatch(phoneNumber.value)) {
  //     return 'Please enter a 10 digits phone number!';
  //   }

  //   return null;
  // }

  // var phoneNumberErrorText = Rx<String?>(null);
  //#endregion

  //#region PASSWORD
  var password = ''.obs;
  // Minimum eight characters, at least one letter and one number:
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  String? passwordValidator() {
    if (!passwordRegex.hasMatch(password.value)) {
      return 'Password must be minimum 8 characters, at least one letter and one number';
    }
    return null;
  }

  var passwordErrorText = Rx<String?>(null);
  //#endregion

  /// Validate user ID and password before sign user in.
  /// ```dart
  /// check empty, and then check with regex
  /// ```
  // void validateAndSignIn() {
  //   var validationSuccess = true;
  //   var fullInput = true;

  //   // validate user id
  //   if (usingEmail.value) {
  //     // validate password
  //     if (password.value.isEmpty) {
  //       passwordErrorText.value = 'Please enter your password!';
  //       fullInput = false;
  //       validationSuccess = false;
  //     } else if (passwordValidator() != null) {
  //       validationSuccess = false;
  //     }

  //     // validate email
  //     if (email.isEmpty) {
  //       emailErrorText.value = 'Please enter your email!';
  //       fullInput = false;
  //       validationSuccess = false;
  //     } else if (emailValidator() != null) {
  //       validationSuccess = false;
  //     }
  //   } else {
  //     // validate phone number
  //     if (phoneNumber.isEmpty) {
  //       phoneNumberErrorText.value = 'Please enter your phone number!';
  //       fullInput = false;
  //       validationSuccess = false;
  //     } else if (phoneNumberValidator() != null) {
  //       validationSuccess = false;
  //     }
  //   }

  //   if (validationSuccess) {
  //     // call api
  //     if (usingEmail.value) {
  //       FirebaseAuth.instance.signInWithEmailAndPassword(email: email.value, password: password.value).then((value) {
  //         print(value);
  //         Get.to(const YouAreIn());
  //       }).catchError((e) {
  //         print(e);
  //       });
  //     } else {
  //       // sign in with phone number
  //       FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber.value).then((value) {
  //         print(value);
  //       }).catchError((e) {
  //         print(e);
  //       });
  //     }
  //   } else {
  //     if (fullInput) {
  //       // shallow authentication
  //       print(' wrong id or password');
  //     }
  //   }
  // }

  void validateEmailAndSignIn() async {
    var validationSuccess = true;
    var fullInput = true;

    // validate password
    if (password.value.isEmpty) {
      passwordErrorText.value = 'Please enter your password!';
      fullInput = false;
      validationSuccess = false;
    } else if (passwordValidator() != null) {
      validationSuccess = false;
    }

    // validate email
    if (email.isEmpty) {
      emailErrorText.value = 'Please enter your email!';
      fullInput = false;
      validationSuccess = false;
    } else if (emailValidator() != null) {
      validationSuccess = false;
    }

    if (validationSuccess) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.value, password: password.value).then((value) {
        FadedOverlay.remove();
        if (!value.user!.emailVerified) {
          _notVerifiedUserHandler(value);
          return;
        }

        print(value);
        Get.to(const YouAreIn());
      }).catchError((e) {
        FadedOverlay.remove();
        showError(e);
      });
    } else {
      FadedOverlay.remove();
      if (fullInput) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'wrong user id or password',
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  void signOut() async {
    // reset email and password
    email('');
    password('');

    // sign out
    await FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(const SignIn());
    }).catchError((e) {
      showError(e);
    });

    FadedOverlay.remove();
  }
}

/// sign out on closing dialog
void _notVerifiedUserHandler(UserCredential credential) {
  Get.defaultDialog(
      barrierDismissible: false,
      title: 'Error',
      content: Column(children: [
        const Text('This account has not been verified, please check your mail box for verifying link.'),
        Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text('Need help?'),
              onPressed: () {
                // quit this dialog
                Get.back();
                /// show need_help dialog, sign out on pop out
                Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Support',
                    content: Column(children: const [
                      Text('You don\'t see the mail? Please check other places such as spam box'),
                      Text('Or'),
                      _SendVerificationLinkButton()
                    ]),
                    onWillPop: () async {
                      // sign out
                      await FirebaseAuth.instance.signOut();
                      return true;
                    });
              },
            ))
      ]),
      textConfirm: 'OK',
      onConfirm: () async {
        // sign out
        await FirebaseAuth.instance.signOut();
        Get.back();
      },
      onWillPop: () async {
        // sign out
        await FirebaseAuth.instance.signOut();
        return true;
      });
}

class _SendVerificationLinkButton extends StatefulWidget {
  const _SendVerificationLinkButton({Key? key}) : super(key: key);

  @override
  State<_SendVerificationLinkButton> createState() => __SendVerificationLinkButtonState();
}

class __SendVerificationLinkButtonState extends State<_SendVerificationLinkButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: isLoading ? const CircularProgressIndicator() : const Text('Resend verification link'),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }
}
