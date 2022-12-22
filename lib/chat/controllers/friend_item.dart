import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../services/user.dart' as dt;

class FriendItemController extends GetxController {
  FriendItemController(this.uid) {
    getCachedUserData().then((_) => listenForChanges());
  }
  final String uid;

  RxMap<String, dynamic> userData = dt.emptyUserData().obs;

  DocumentReference<Map<String, dynamic>> get userDocRef => FirebaseFirestore.instance.collection('users').doc(uid);

  Future<void> getCachedUserData() async {
    return userDocRef.get(const GetOptions(source: Source.cache)).then((doc){userData(doc.data());}).catchError((e){}, test: (e)=>true);
  }

  void listenForChanges() {
    userDocRef.snapshots().listen((event) {
      if (event.exists) {
        print('modified');
        userData(event.data());
      } else {
        userData(dt.emptyUserData());
      }
    });
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
