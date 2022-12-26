import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../services/user.dart' as dt;

class UserItemController extends GetxController {
  UserItemController(this.uid) {
    getCachedUserData().then((_) => listenForChanges());
  }

  final String uid;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener;

  RxMap<String, dynamic> userData = dt.emptyUserData().obs;

  DocumentReference<Map<String, dynamic>> get userDocRef => FirebaseFirestore.instance.collection('users').doc(uid);

  Future<void> getCachedUserData() async {
    return userDocRef.get(const GetOptions(source: Source.cache)).then((doc){userData(doc.data());}).catchError((e){}, test: (e)=>true);
  }

  void listenForChanges() {
    listener = userDocRef.snapshots().listen((event) {
      if (event.exists) {
        print('modified');
        userData(event.data());
      } else {
        userData(dt.emptyUserData());
      }
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }
}

class UserItemControllers {
  static UserItemControllers? _inst;
  UserItemControllers._internal();
  static UserItemControllers get inst {
    _inst ??= UserItemControllers._internal();
    return _inst!;
  }

  HashMap<String, UserItemController> controllers = HashMap();

  UserItemController getOrCreate(String uid){
    var foundController = controllers[uid];
    
    if (foundController != null) return foundController;

    controllers[uid] = UserItemController(uid);
    return controllers[uid]!;
  }
}

// class FriendItemControllers {
//   static FriendItemControllers? _inst;
//   FriendItemControllers._internal();
//   static FriendItemControllers get inst {
//     _inst ??= FriendItemControllers._internal();
//     return _inst!;
//   }

//   HashMap<String, FriendItemController> controllers = HashMap();

//   FriendItemController add(String uid) {
//     FriendItemController c = FriendItemController(uid);
//     controllers[uid] = c;
//     return c;
//   }

//   FriendItemController get(String uid) {
//     return controllers[uid]!;
//   }
// }
