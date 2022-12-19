import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [Text('MyProfile'),
      TextButton(child: Text('Present lang is ${Get.locale}'),onPressed: (){
        if (Get.locale == const Locale('en', 'US')) {
          Get.updateLocale(const Locale('vi', 'VN'));
        } else {
          Get.updateLocale(const Locale('en', 'US'));
        }
      },)
      ],
    ));
  }
}
