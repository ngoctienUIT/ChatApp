import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../services/user_data.dart' as dt;

class FriendItemController extends GetxController {
  FriendItemController(this.uid){
    userData = dt.newUserData().obs;
  }
  late String uid;
  late RxMap<String, dynamic> userData;

  Future<Map<String, dynamic>> get cachedUserData async {
    final users = FirebaseFirestore.instance.collection('users');
    var doc = await users.doc(uid).get(const GetOptions(source: Source.cache));
    if (!doc.exists) throw Exception('User not found');
    userData(doc.data());
    return userData;
  }

  Future<Map<String, dynamic>> get newUserData async {
    final users = FirebaseFirestore.instance.collection('users');
    var doc = await users.doc(uid).get(const GetOptions(source: Source.serverAndCache));
    if (!doc.exists) throw Exception('User not found');
    userData(doc.data());
    return userData;
  }
}

class FriendItemControllers {
  static FriendItemControllers? _inst;
  FriendItemControllers._internal();
  static FriendItemControllers get inst {
    _inst ??= FriendItemControllers._internal();
    return _inst!;
  }

  var controllers = <String, FriendItemController>{};

  FriendItemController add(String uid) {
    FriendItemController c = Get.put(FriendItemController(uid));
    controllers[uid] = c;
    return c;
  }

  FriendItemController get(String uid) {
    return controllers[uid]!;
  }
}