import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> findExistingPrivateChatId(String uid) async {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var chatDoc = await FirebaseFirestore.instance.collection('users/$currentUserId/chats').doc(uid).get(const GetOptions(source: Source.cache));
  if (chatDoc.exists) {
    return chatDoc['id'];
  } else {
    chatDoc = await FirebaseFirestore.instance.collection('users/$currentUserId/chats').doc(uid).get(const GetOptions(source: Source.serverAndCache));
    if (chatDoc.exists) {
      return chatDoc['id'];
    } else {
      throw Exception('Private chat not found with user: $uid');
    }
  }
}
