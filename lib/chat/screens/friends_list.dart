import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/friends_list.dart';

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
    print('init parent');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(children: [
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
      const _FriendsList()
    ]);
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
    print('init list');
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

class _FriendItem extends StatelessWidget {
  const _FriendItem(this.uid, {Key? key}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  //Get.to(const Chat());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          _ProfilePicture(snapshot.data['profile_picture']),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: snapshot.data['is_active'] ? Colors.green : Colors.grey,
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
                          snapshot.data['name'],
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
                        onPressed: () {},
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
        });
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
          placeholder: (context, url) => Image.asset(
            "assets/images/avatar.jpg",
            width: 50,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
