import 'package:flutter/material.dart';

Widget customButton({required Function onPress, required String text}) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(27, 150, 200, 1),
          Color.fromRGBO(15, 202, 177, 1)
        ]),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 5),
          ),
        ]),
    child: ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
