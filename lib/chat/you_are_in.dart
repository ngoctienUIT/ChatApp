import 'package:chat_app/chat/screens/friends_list/friends.dart';
import 'package:chat_app/chat/screens/profile/profile.dart';
import 'package:chat_app/chat/screens/messages/list_chat.dart';
import 'package:chat_app/chat/services/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YouAreIn extends StatefulWidget {
  const YouAreIn({Key? key}) : super(key: key);

  @override
  State<YouAreIn> createState() => _YouAreInState();
}

class _YouAreInState extends State<YouAreIn> with WidgetsBindingObserver {
  int currentTab = 0;
  List<Widget> screens = [
    const ListChat(),
    const Friends(),
    const Profile(),
  ];

  DateTime? currentBackPressTime;
  final PageStorageBucket bucket = PageStorageBucket();
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // loadUserData(() {
    //   setState(() => _isLoading = false);
    //   // setUserActive();
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // setState(() {
        //   title = message.notification!.title!;
        //   body = message.notification!.body!;
        // });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setUserActive();
    } else {
      setUserOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (_isLoading) {
    //   return const Scaffold(
    //     body: Center(
    //       child: SizedBox(
    //         width: 100,
    //         child: LoadingIndicator(indicatorType: Indicator.ballPulseRise),
    //       ),
    //     ),
    //   );
    // }

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
                      ? FontAwesomeIcons.users
                      : FontAwesomeIcons.users,
                  color: currentTab == 1 ? Colors.green : Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() => currentTab = 2);
                },
                child: Icon(
                  currentTab == 2
                      ? FontAwesomeIcons.solidUser
                      : FontAwesomeIcons.user,
                  color: currentTab == 2 ? Colors.green : Colors.grey,
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
