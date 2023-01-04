import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/models/content_messages.dart';
import 'package:chat_app/chat/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> findExistingPrivateChatId(String uid) async {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var chatDoc = await FirebaseFirestore.instance
      .collection('users/$currentUserId/chats')
      .doc(uid)
      .get(const GetOptions(source: Source.cache));
  if (chatDoc.exists) {
    return chatDoc['id'];
  } else {
    chatDoc = await FirebaseFirestore.instance
        .collection('users/$currentUserId/chats')
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache));
    if (chatDoc.exists) {
      return chatDoc['id'];
    } else {
      throw Exception('Private chat not found with user: $uid');
    }
  }
}

Future initChat(String id, ChatRoom chatRoom) async {
  // init room chat
  FirebaseFirestore.instance
      .collection("private_chats")
      .doc(id)
      .set(chatRoom.toMap());

  // save room chat id
  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user1.id)
      .collection("private_chats")
      .doc(chatRoom.user2.id)
      .set({"chat_id": id});

  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user2.id)
      .collection("private_chats")
      .doc(chatRoom.user1.id)
      .set({"chat_id": id});

  //add friend
  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user1.id)
      .collection("friends")
      .doc(chatRoom.user2.id)
      .set({});

  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user2.id)
      .collection("friends")
      .doc(chatRoom.user1.id)
      .set({});
}

Future sendMessages(
  String id,
  ChatRoom chatRoom,
  ContentMessages content,
) async {
  if (!await checkExist(id)) initChat(id, chatRoom);
  await FirebaseFirestore.instance
      .collection("private_chats")
      .doc(id)
      .collection("chats")
      .doc(DateTime.now().microsecondsSinceEpoch.toString())
      .set(
        Messages(
          sender: FirebaseAuth.instance.currentUser!.uid,
          content: content,
          timestamp: DateTime.now(),
        ).toMap(),
      );
}

Future deleteChat(String id, ChatRoom chatRoom) async {
  final instance = FirebaseFirestore.instance;
  final batch = instance.batch();
  //delete info room chat
  await instance.collection("private_chats").doc(id).delete();
  // delete all chat
  var snapshots = await instance
      .collection("private_chats")
      .doc(id)
      .collection("chats")
      .get();
  for (var doc in snapshots.docs) {
    batch.delete(doc.reference);
  }
  await batch.commit();
  // delete id room in user 1
  await instance
      .collection("users")
      .doc(chatRoom.user1.id)
      .collection("private_chats")
      .doc(chatRoom.user2.id)
      .delete();
  // delete id room in user 2
  await instance
      .collection("users")
      .doc(chatRoom.user2.id)
      .collection("private_chats")
      .doc(chatRoom.user1.id)
      .delete();
  // delete all file in chat room
  FirebaseStorage.instance.ref().child(id).delete();
}

Future<bool> checkExist(String id) async {
  bool check = true;
  await FirebaseFirestore.instance
      .collection("private_chats")
      .doc(id)
      .get()
      .then((value) {
    if (!value.exists) check = false;
  });
  return check;
}
