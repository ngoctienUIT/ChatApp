import 'package:chat_app/languages/en.dart';
import 'package:chat_app/languages/vn.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vn,
      };
}