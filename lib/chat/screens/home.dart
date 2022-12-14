import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('home')),
      floatingActionButton: FloatingActionButton(
      onPressed: () { },
      child: Icon(Icons.add),
    ),);
  }
}
