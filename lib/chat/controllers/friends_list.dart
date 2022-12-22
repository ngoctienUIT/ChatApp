import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FriendsListController extends GetxController {
  static FriendsListController? _inst;
  static FriendsListController get inst {
    _inst ??= FriendsListController._internal();
    return _inst!;
  }

  FriendsListController._internal(): super();

  var friendsList = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> get cachedFriendsList async {
   // final users = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid;

    var friendsSnapshot = await FirebaseFirestore.instance.collection('users/$userId/friends').get(const GetOptions(source: Source.cache));
    friendsList(friendsSnapshot.docs);
    return friendsList;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> get newFriendsList async {
   // final users = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid;

 var friendsSnapshot = await FirebaseFirestore.instance.collection('users/$userId/friends').get();
    friendsList(friendsSnapshot.docs);
    return friendsList;
  }
}
