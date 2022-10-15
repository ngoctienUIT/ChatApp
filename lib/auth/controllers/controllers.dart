import 'package:get/get.dart';

// TODO
// press sign in button: check states are still empty or not
class SignInController extends GetxController {
  static final SignInController _inst = Get.put(SignInController());
  static SignInController get inst => _inst;

  var usingEmail = true.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  validateAndSignIn() {

  }
}
