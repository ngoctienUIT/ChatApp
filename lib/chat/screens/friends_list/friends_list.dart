import 'package:chat_app/chat/controllers/friend_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/friends_list.dart';
import '../../widgets/active_color.dart';
import '../../widgets/profile_picture.dart';
import '../conversation.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({Key? key}) : super(key: key);

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> with AutomaticKeepAliveClientMixin<FriendsListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(child:Column(children: [
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
      ElevatedButton(onPressed: (){FriendsListController.inst.newFriendsList;}, child: const Text('Refesh'))
      
    ]));
  }
}

class _FriendsList extends StatefulWidget {
  const _FriendsList({Key? key}) : super(key: key);

  @override
  State<_FriendsList> createState() => __FriendsListState();
}

class __FriendsListState extends State<_FriendsList> {
  @override
  void initState() {
    super.initState();
    var c = FriendsListController.inst;
    c.cachedFriendsList.then(
      (value) => c.newFriendsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: FriendsListController.inst.friendsList.map((item) => _FriendItem(item)).toList()));
  }
}
 
class _FriendItem extends StatefulWidget {
  const _FriendItem(this.friendData, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> friendData;
  @override
  State<_FriendItem> createState() => __FriendItemState();
}

class __FriendItemState extends State<_FriendItem> {
  late FriendItemController controller;
  @override
  void initState() {
    super.initState();
    controller = FriendItemControllers.inst.add(widget.friendData.id);
    controller.cachedUserData.then(
      (value) => controller.newUserData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: () {
            Get.to(()=>Conversation.withFriend(widget.friendData));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    ProfilePicture(controller.userData['profile_picture']),
                    Positioned(
                      right: 0,
                      child: Container(
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
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    controller.userData['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  onPressed: () {
                    Get.to(()=>Conversation.withFriend(widget.friendData));
                  },
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
