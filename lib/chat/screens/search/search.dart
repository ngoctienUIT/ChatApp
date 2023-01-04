import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/screens/messages/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:chat_app/chat/models/user.dart' as myuser;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Search",
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
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintStyle: const TextStyle(fontSize: 16),
                  filled: true,
                  fillColor: const Color.fromRGBO(234, 235, 237, 1),
                  hintText: "Tìm kiếm",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection("users").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && _searchController.text.isNotEmpty) {
                    var data = snapshot.requireData;
                    List<myuser.User> users = [];
                    for (var doc in data.docs) {
                      if (doc.id.compareTo(
                              FirebaseAuth.instance.currentUser!.uid) !=
                          0) {
                        myuser.User user = myuser.User.fromFirebase(doc);
                        user.id = doc.id;
                        users.add(user);
                      }
                    }
                    users = users
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              myuser.User user = (await myuser.User.getInfoUser(
                                  FirebaseAuth.instance.currentUser!.uid))!;
                              Get.to(
                                Chat(
                                  chatRoom: ChatRoom(
                                    id: "${FirebaseAuth.instance.currentUser!.uid}-${users[index].id}",
                                    user1: myuser.User(
                                      id: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      name: user.name,
                                    ),
                                    user2: myuser.User(
                                      id: users[index].id,
                                      name: users[index].name,
                                    ),
                                    mainReaction: "",
                                    theme: "",
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          "assets/images/avatar.jpg",
                                          width: 50,
                                        ),
                                      ),
                                      if (index % 3 != 0)
                                        Positioned(
                                          right: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(90),
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
                                      users[index].name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
