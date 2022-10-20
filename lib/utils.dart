
// void announce(BuildContext context, String title, String message) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//         );
//       });
// }

// use Getx dialog instead !!

import 'package:get/get.dart';

void showError(e){
        Get.defaultDialog(
        title: 'Error',
        middleText: e.toString(),
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
}