import 'package:chat_app/auth/screens/list_chat.dart';
import 'package:chat_app/auth/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  List<Widget> screens = [
    const ListChat(),
    const Profile(),
  ];

  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: screens[currentTab],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        elevation: 5,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() => currentTab = 0);
                },
                child: Icon(
                  currentTab == 0
                      ? FontAwesomeIcons.solidComment
                      : FontAwesomeIcons.comment,
                  color: currentTab == 0 ? Colors.green : Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() => currentTab = 1);
                },
                child: Icon(
                  currentTab == 1
                      ? FontAwesomeIcons.solidUser
                      : FontAwesomeIcons.user,
                  color: currentTab == 1 ? Colors.green : Colors.grey,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
