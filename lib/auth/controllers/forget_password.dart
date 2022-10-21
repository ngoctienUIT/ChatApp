import 'package:chat_app/auth/widgets/faded_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils.dart';
import '../screens/sign_in.dart';
import 'sign_in.dart';

class ForgetPasswordController extends GetxController {
  static final ForgetPasswordController _inst = Get.put(ForgetPasswordController());
  static ForgetPasswordController get inst => _inst;

  final email = ''.obs;

  String? emailValidator() {
    if (!SignInController.inst.emailRegex.hasMatch(email.value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  final emailErrorText = Rx<String?>(null);

  void validateAndSendResetLink() async {
    // validate
    if (email.isEmpty) {
      emailErrorText.value = 'Please enter your email';
      FadedOverlay.remove();
      return;
    } else {
      emailErrorText.value = emailValidator();
      if (emailErrorText.value != null) {
        FadedOverlay.remove();
        return;
      }
    }

    // send reset link
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.value);
      FadedOverlay.remove();
            // show dialog for success registration, press btn to confirm and then navigate to sign in screen
      await Get.defaultDialog(
          title: 'Successful sending email',
          middleText: 'Please check your mail box to change to your password',
          onWillPop: () async {
            Get.offAll(const SignIn());
            return true;
          });
    } on FirebaseAuthException catch (e) {
      FadedOverlay.remove();
      switch (e.code) {
        case 'auth/invalid-email':
          // Thrown if the email address is not valid.
          emailErrorText.value = 'Please enter a valid email';
          break;

        case 'auth/missing-android-pkg-name':
          //An Android package name must be provided if the Android app is required to be installed.
          showError('An Android package name must be provided if the Android app is required to be installed.');
          break;
        case 'auth/missing-continue-uri':
          //A continue URL must be provided in the request.
          showError('A continue URL must be provided in the request.');
          break;
        case 'auth/missing-ios-bundle-id':
          //An iOS Bundle ID must be provided if an App Store ID is provided.
          showError('An iOS Bundle ID must be provided if an App Store ID is provided.');
          break;
        case 'auth/invalid-continue-uri':
          //The continue URL provided in the request is invalid.
          showError('The continue URL provided in the request is invalid.');
          break;
        case 'auth/unauthorized-continue-uri':
          //The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.
          showError('The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.');
          break;
        case 'auth/user-not-found':
          //Thrown if there is no user corresponding to the email address.
          showError('This is not a existing account in our system');
          break;
      }
    } catch (e) {
      FadedOverlay.remove();
      showError(e);
    }
  }
}
