import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FriendsListController extends GetxController {
  static FriendsListController? _inst;
  static FriendsListController get inst {
    print('init c');
    _inst ??= Get.put(FriendsListController._internal());
    return _inst!;
  }

  FriendsListController._internal();

  RxList<dynamic> friendsList = [].obs;

  Future<List<dynamic>> get cachedFriendsList async {
    final users = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid.toString();

    friendsList((await users.doc(userId).get(const GetOptions(source: Source.cache)))['friends']);
    return friendsList;
  }

  Future<List<dynamic>> get newFriendsList async {
    final users = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid.toString();

    friendsList((await users.doc(userId).get(const GetOptions(source: Source.serverAndCache)))['friends']);
    return friendsList;
  }
}
