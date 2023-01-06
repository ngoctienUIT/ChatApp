import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/screens/messages/chat.dart';
import 'package:chat_app/chat/screens/search/search.dart';
import 'package:chat_app/chat/services/chat.dart';
import 'package:chat_app/chat/widgets/option_chat.dart';
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
              onPressed: () => Get.to(const Search()),
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
      onTap: () => Get.to(Chat(chatRoom: chatRoom)),
      onLongPress: () => showOptionChat(chatRoom),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Image.asset("assets/images/avatar.jpg", width: 50),
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

  void showOptionChat(ChatRoom chatRoom) {
    bool checkUser =
        FirebaseAuth.instance.currentUser!.uid == chatRoom.user1.id;
    bool checkNotify =
        checkUser ? chatRoom.user1.notify : chatRoom.user2.notify;
    Get.bottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      Container(
        height: 150,
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => changeNotify(chatRoom),
              child: Row(
                children: [
                  Icon(
                    checkNotify
                        ? FontAwesomeIcons.bellSlash
                        : FontAwesomeIcons.solidBell,
                    color: const Color.fromRGBO(59, 190, 253, 1),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    checkNotify ? 'Tắt thông báo' : 'Bật thông báo',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => showDialogDelete(chatRoom),
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.trash,
                    color: Color.fromRGBO(255, 113, 150, 1),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Xóa đoạn chat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.ban,
                    color: Color.fromRGBO(252, 177, 188, 1),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Chặn',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
