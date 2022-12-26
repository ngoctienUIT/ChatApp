import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with AutomaticKeepAliveClientMixin<MessagesPage> {
  @override
  void activate() {
    //print('activate');
    super.activate();
  }

  @override
  void deactivate() {
   // print('deactivate');
    super.deactivate();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    //print('build');
    super.build(context);
    return SafeArea(
        child: Column(
      children: [Text('Messages')],
    ));
  }
}
