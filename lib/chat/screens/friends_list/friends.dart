import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/screens/messages/chat.dart';
import 'package:chat_app/chat/screens/search/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:chat_app/chat/models/user.dart' as myuser;

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

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
                        Get.to(const Search());
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("friends")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> id = [];
                    for (var doc in snapshot.requireData.docs) {
                      id.add(doc.id);
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: id.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(id[index])
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  myuser.User user = myuser.User.fromFirebase(
                                      snapshot.requireData);

                                  return InkWell(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("private_chats")
                                          .doc(id[index])
                                          .get()
                                          .then((value) {
                                        var data = value.data();
                                        String id = data!["chat_id"];
                                        //TODO
                                        // Get.to(const Chat(
                                        //   chatRoom: ChatRoom(),
                                        // ));
                                      });
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
                                                          BorderRadius.circular(
                                                              90),
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
                                              user.name,
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
                                              color: Color.fromRGBO(
                                                  77, 189, 204, 1),
                                              size: 20,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              FontAwesomeIcons.comment,
                                              color: Color.fromRGBO(
                                                  77, 189, 204, 1),
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return Container();
                              });
                        },
                      ),
                    );
                  }

                  return Container();
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(26, 157, 196, 1),
                Color.fromRGBO(21, 201, 179, 1)
              ],
            ),
          ),
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
