import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/screens/messages/chat.dart';
import 'package:chat_app/chat/screens/search/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ListChat extends StatelessWidget {
  const ListChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [header(), body()]),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Chat",
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
    );
  }

  Widget body() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("private_chats")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> chats = [];
            for (var doc in snapshot.requireData.docs) {
              chats.add(doc["chat_id"]);
            }
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("private_chats")
                          .doc(chats[index])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ChatRoom chatRoom =
                              ChatRoom.fromFirebase(snapshot.requireData);
                          return itemChat(chatRoom);
                        }

                        return Container();
                      });
                },
              ),
            );
          }

          return Expanded(child: Container());
        });
  }

  Widget itemChat(ChatRoom chatRoom) {
    return InkWell(
      onTap: () {
        Get.to(Chat(chatRoom: chatRoom));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                if (chatRoom.user1.isActive)
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        chatRoom.user1.id.compareTo(
                                    FirebaseAuth.instance.currentUser!.uid) ==
                                0
                            ? chatRoom.user2.name
                            : chatRoom.user1.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "10:00 PM",
                        style: TextStyle(color: Colors.black38),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Messenger", style: TextStyle(fontSize: 16))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
