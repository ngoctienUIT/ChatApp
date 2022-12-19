import 'package:chat_app/chat/screens/create_story.dart';
import 'package:chat_app/chat/screens/friends_list.dart';
import 'package:chat_app/chat/screens/messages.dart';
import 'package:chat_app/chat/screens/my_profile.dart';
import 'package:chat_app/chat/services/get_user_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'screens/home/home.dart';

class YouAreIn extends StatefulWidget {
  const YouAreIn({Key? key}) : super(key: key);

  @override
  State<YouAreIn> createState() => _YouAreInState();
}

class _YouAreInState extends State<YouAreIn> {
  int _selectedIndex = 0;
  bool _loadSuccess = false;

  static const List<Widget> _widgetOptions = <Widget>[Home(), Messages(), CreateStory(), FriendsList(), MyProfile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData((){setState(() {
      _loadSuccess = true;
    });});
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadSuccess) {
      return const Center(
        child: SizedBox(height: 100, child: LoadingIndicator(indicatorType: Indicator.ballPulseSync))
      );
    }
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'message'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera), label: 'create-story'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: 'people'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black45,
        onTap: _onItemTapped,
      ),
    );
  }
}
