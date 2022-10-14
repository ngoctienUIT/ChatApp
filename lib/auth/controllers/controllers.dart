import 'package:get/get.dart';

class SignInController extends GetxController {
  static final SignInController _inst = Get.put(SignInController());
  static SignInController get inst => _inst;

  var usingEmail = true.obs;
  var phoneNumber = ''.obs;

  validate(){
    
  }
}
