import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/widgets/loading_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/chat/models/user.dart' as myuser;

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    String id = FirebaseAuth.instance.currentUser!.uid == chatRoom.user1.id
        ? chatRoom.user2.id
        : chatRoom.user1.id;
    return Row(
      children: [
        FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance.collection("users").doc(id).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                myuser.User user =
                    myuser.User.fromFirebase(snapshot.requireData);
                return ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.image!,
                    width: 40,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => loadingImage(
                      width: 40,
                      height: 40,
                      radius: 90,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              }
              return const SizedBox(width: 40, height: 40);
            }),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatRoom.user1.id.compareTo(
                            FirebaseAuth.instance.currentUser!.uid) ==
                        0
                    ? chatRoom.user2.name
                    : chatRoom.user1.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Đang hoạt động",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
