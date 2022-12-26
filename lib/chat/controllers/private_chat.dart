import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'user_item.dart';

Map<String, dynamic> firstChat(){
  return {};
}

class PrivateChatController extends GetxController {
  PrivateChatController.firstChat(this.withUser){
    userController = UserItemControllers.inst.getOrCreate(withUser);
    // create new chat
    FirebaseFirestore.instance.collection('private_chats').add({});
  }

  PrivateChatController.continueChat(this.withUser){
    userController = UserItemControllers.inst.getOrCreate(withUser);
    // find chat doc in current_user[chats]

  }

  final String withUser;
  late UserItemController userController;

  // Future<void> getCachedData() async {
  //   // get chat doc

  //   String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //   var private_chat_id = FirebaseFirestore.instance.collection('users/$currentUserId/chats')
  //   return FirebaseFirestore.instance.collection('private_chats').doc(smt)
  // }
}