import 'package:chat_app/chat/controllers/user_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/friends_list.dart';
import '../../widgets/active_color.dart';
import '../../widgets/profile_picture.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({Key? key}) : super(key: key);

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  @override
  void initState() {
    super.initState();
    lazyResumeRealtime();
  }

  Future<void> lazyResumeRealtime() async {
    FriendsListController.inst.resumeRealTime();
    FriendsListController.inst.friendsMap.value.forEach((key, value) => UserItemControllers.inst.resumeRealtime(key));
  }

  @override
  void dispose() {
    FriendsListController.inst.pauseRealTime();
    FriendsListController.inst.friendsMap.value.forEach((key, value) => UserItemControllers.inst.pauseRealtime(key));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Friends",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 45,
              width: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                onPressed: () {
                  // Get.to(const Search());
                },
                child: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
      const _FriendsList(),
    ]));
  }
}

class _FriendsList extends StatelessWidget {
  const _FriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: FriendsListController.inst.friendsMap.value.entries
            .map((entry) => _FriendItem(controller: UserItemControllers.inst.getOrCreate(entry.key)))
            .toList()));
  }
}

class _FriendItem extends StatelessWidget {
  const _FriendItem({required this.controller, Key? key}) : super(key: key);

  final UserItemController controller;

  void navToChatScreen() {
    // Get.to(Conversation)
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: navToChatScreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    Obx(() => ProfilePicture(controller.userData['profile_picture'])),
                    Positioned(
                      right: 0,
                      child: Obx(() => Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: activeColor(controller.userData['is_active']),
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Obx(() => Text(
                        controller.userData['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.phone,
                    color: Color.fromRGBO(77, 189, 204, 1),
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: navToChatScreen,
                  icon: const Icon(
                    FontAwesomeIcons.comment,
                    color: Color.fromRGBO(77, 189, 204, 1),
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //       gradient: LinearGradient(
      //         colors: [Color.fromRGBO(26, 157, 196, 1), Color.fromRGBO(21, 201, 179, 1)],
      //       ),
      //     ),
      //     child: const Icon(Icons.add, size: 30),
      //   ),
      // ),
