import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget customButtonLogin(
    {required String text,
    required IconData icon,
    required Function onPress,
    required Color color}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0), backgroundColor: color),
      onPressed: () {
        onPress();
      },
      child: Row(
        children: [
          SizedBox(width: 60, child: Center(child: Icon(icon))),
          const VerticalDivider(
            color: Colors.white,
            width: 1,
            endIndent: 7,
            indent: 7,
          ),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
