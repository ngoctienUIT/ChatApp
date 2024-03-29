import 'dart:convert';
import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/models/content_messages.dart';
import 'package:chat_app/chat/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/chat/models/user.dart' as myuser;

String baseURL = "https://fcm.googleapis.com/fcm/send";
String serverKey =
    "key=AAAAKDWX1SQ:APA91bGSKguvK1e4NZPyPrhcDPdki4ujqGxBo1tpoydj0LAL7gq4GpRUe16N0-l9BF13bBAZV9nHYqwoStiDnC1zuw4pX7aGbD3ugGUfm8wm8sFWbMavp2SwHqT8AOL3E3mJjSGuQEsz";

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

Future initChat(ChatRoom chatRoom) async {
  // init room chat
  FirebaseFirestore.instance
      .collection("private_chats")
      .doc(chatRoom.id)
      .set(chatRoom.toMap());

  // save room chat id
  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user1.id)
      .collection("private_chats")
      .doc(chatRoom.user2.id)
      .set({"chat_id": chatRoom.id});

  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user2.id)
      .collection("private_chats")
      .doc(chatRoom.user1.id)
      .set({"chat_id": chatRoom.id});

  //add friend
  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user1.id)
      .collection("friends")
      .doc(chatRoom.user2.id)
      .set({"chat_id": chatRoom.id});

  FirebaseFirestore.instance
      .collection("users")
      .doc(chatRoom.user2.id)
      .collection("friends")
      .doc(chatRoom.user1.id)
      .set({"chat_id": chatRoom.id});
}

Future sendMessages(
  ChatRoom chatRoom,
  ContentMessages content,
) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  if (!await checkExist(chatRoom.id)) initChat(chatRoom);
  myuser.User receiveUser =
      uid == chatRoom.user1.id ? chatRoom.user2 : chatRoom.user1;
  myuser.User sendUser =
      uid == chatRoom.user1.id ? chatRoom.user1 : chatRoom.user2;
  String body = contentFCM(content.activity) ?? content.text!;
  FirebaseFirestore.instance
      .collection("users")
      .doc(receiveUser.id)
      .get()
      .then((value) {
    String token = value.data()!["token"];
    sendPushMessage(
        token: token, id: chatRoom.id, body: body, title: sendUser.name);
  });
  await FirebaseFirestore.instance
      .collection("private_chats")
      .doc(chatRoom.id)
      .collection("chats")
      .doc(DateTime.now().microsecondsSinceEpoch.toString())
      .set(Messages(
        sender: uid,
        content: content,
        timestamp: DateTime.now(),
      ).toMap());
}

String? contentFCM(int id) {
  switch (id) {
    case 0:
      return "Đã gọi cho bạn";
    case 1:
      return "Đã gửi tệp tin";
    case 2:
      return "Đã gửi hình ảnh";
    case 3:
      return "Đã gửi hội thoại";
    case 4:
      return "Đã gửi sticker";
    default:
      return null;
  }
}

Future deleteChat(ChatRoom chatRoom) async {
  final instance = FirebaseFirestore.instance;
  final batch = instance.batch();
  //delete info room chat
  await instance.collection("private_chats").doc(chatRoom.id).delete();
  // delete all chat
  var snapshots = await instance
      .collection("private_chats")
      .doc(chatRoom.id)
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
  FirebaseStorage.instance.ref().child(chatRoom.id).delete();
}

Future<bool> checkExist(String id) async {
  var doc = await FirebaseFirestore.instance
      .collection("private_chats")
      .doc(id)
      .get();
  return doc.exists;
}

Future<String?> checkExistPrivateChat(String id1, String id2) async {
  bool check = await checkExist("$id1-$id2");
  if (check) {
    return "$id1-$id2";
  }
  check = await checkExist("$id2-$id1");
  if (check) {
    return "$id2-$id1";
  }
  return null;
}

Future sendPushMessage({
  required String token,
  required String id,
  required String body,
  required String title,
}) async {
  try {
    Map<String, String> headerFCM = {
      "Content-Type": "application/json",
      "Authorization": serverKey,
    };

    Map<String, dynamic> bodyFCM = {
      'notification': <String, dynamic>{'body': body, 'title': title},
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': id,
        'status': 'done'
      },
      "to": token,
    };

    http.post(
      Uri.parse(baseURL),
      headers: headerFCM,
      body: jsonEncode(bodyFCM),
    );
  } catch (_) {}
}
