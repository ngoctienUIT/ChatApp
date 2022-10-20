import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../screens/sign_in.dart';
import '../widgets/faded_overlay.dart';
import 'sign_in.dart';

class SignUpController extends GetxController {
  static final SignUpController _inst = Get.put(SignUpController());
  static SignUpController get inst => _inst;

  //#region NAME
  var name = ''.obs;
  RegExp nameRegex = RegExp(r'(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})');
  String? nameValidator() {
    if (!nameRegex.hasMatch(name.value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  var nameErrorText = Rx<String?>(null);
  //#endregion

  //#region EMAIL
  var email = ''.obs;

  String? emailValidator() {
    if (!SignInController.inst.emailRegex.hasMatch(email.value)) {
      return 'Please enter a valid email!';
    }

    return null;
  }

  var emailErrorText = Rx<String?>(null);
  //#endregion

  //#region PASSWORD
  var password = ''.obs;

  String? passwordValidator() {
    if (!SignInController.inst.passwordRegex.hasMatch(password.value)) {
      return passwordHint;
    }
    return null;
  }

  var passwordErrorText = Rx<String?>(null);
  String passwordHint = 'Password must be minimum 8 characters, at least one letter and one number';
  //#endregion

  void validateAndSignUp() async {
    var validationSuccess = true;
    var fullInput = true;

    // validate password
    if (password.value.isEmpty) {
      passwordErrorText.value = 'Please enter your password!';
      fullInput = false;
      validationSuccess = false;
    } else {
      passwordErrorText.value = passwordValidator();
      if (passwordErrorText.value != null) {
        validationSuccess = false;
      }
    }

    // validate email
    if (email.isEmpty) {
      emailErrorText.value = 'Please enter your email!';
      fullInput = false;
      validationSuccess = false;
    } else {
      emailErrorText.value = emailValidator();
      if (emailErrorText.value != null) {
        validationSuccess = false;
      }
    }

    // validate name
    if (name.isEmpty) {
      nameErrorText.value = 'Please enter your name';
      fullInput = false;
      validationSuccess = false;
    } else {
      nameErrorText.value = nameValidator();
      if (nameErrorText.value != null) {
        validationSuccess = false;
      }
    }

    if (validationSuccess) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.value, password: password.value).then((value) {
        FadedOverlay.remove();
        value.user!.sendEmailVerification();
        // show dialog for success registration, press btn to confirm and then navigate to sign in screen
        Get.defaultDialog(
            title: 'Successful registration',
            middleText: 'Please check you mail box to verify your email',
            textConfirm: 'OK',
            onConfirm: () {
              // reset sign up data
              // password
              passwordErrorText.value = null;

              // verify email


              Get.offAll(const SignIn());
            });
      }).catchError((e) {
        print(e);
        // show dialog for error
        Get.defaultDialog(
          title: 'Error',
          middleText: e.toString(),
          textConfirm: 'OK',
          onConfirm: (){Get.back();}
        );
      });

      return;
    } else {
      if (fullInput) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'wrong user id or password',
          textConfirm: 'OK',
          onConfirm: (){Get.back();}
        );
      }
    }

    FadedOverlay.remove();
  }

  // void signOut() async {
  //   // reset email and password
  //   email('');
  //   password('');

  //   // sign out
  //   await FirebaseAuth.instance.signOut().then((_) {
  //     Get.offAll(const SignIn());
  //   }).catchError((e) {
  //     print(e);
  //   });

  //   FadedOverlay.remove();
  // }
}
