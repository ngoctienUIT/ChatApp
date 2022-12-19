import 'package:chat_app/chat/screens/create_story.dart';
import 'package:chat_app/chat/screens/friends_list/friends_list.dart';
import 'package:chat_app/chat/screens/messages.dart';
import 'package:chat_app/chat/screens/my_profile.dart';
import 'package:chat_app/chat/services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'screens/home/home.dart';

class YouAreIn extends StatefulWidget {
  const YouAreIn({Key? key}) : super(key: key);

  @override
  State<YouAreIn> createState() => _YouAreInState();
}

class _YouAreInState extends State<YouAreIn> with SingleTickerProviderStateMixin {
  static const List<Widget> _pages = <Widget>[Home(), Messages(), CreateStory(), FriendsListPage(), MyProfile()];
  static const List<BottomNavigationBarItem> _tabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'message'),
    BottomNavigationBarItem(icon: Icon(Icons.photo_camera), label: 'create-story'),
    BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: 'people'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
  ];

  int _currentIndex = 0;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    loadUserData(() => setState(
          () => _isLoading = false,
        ));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(
              child: SizedBox(
        width: 100,
        child: LoadingIndicator(indicatorType: Indicator.ballPulseRise),
      )));
    }
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _tabs,
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black45,
      ),
    );
  }
}
