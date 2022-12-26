import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// auto enable realtime when init
class FriendsListController extends GetxController {
  static FriendsListController? _inst;
  static FriendsListController get inst {
    _inst ??= FriendsListController._internal();
    return _inst!;
  }

  FriendsListController._internal(){
        getCachedFriendsMap().then((_) {
      listenForChanges();
    });
  }

  Rx<HashMap<String, dynamic>> friendsMap = HashMap<String, dynamic>().obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? listener;

  String get currentUserId =>FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get friendsCollectionRef {
    return FirebaseFirestore.instance.collection('users/$currentUserId/friends');
  }

  Future<void> getCachedFriendsMap() async {
    var friendsSnapshot = await friendsCollectionRef.get(const GetOptions(source: Source.cache));
    for (var doc in friendsSnapshot.docs) {
      friendsMap.value[doc.id] = doc.data();
    }
    friendsMap.refresh();
  }

  void resumeRealTime(){
    listener?.resume();
  }

  void pauseRealTime(){
    listener?.pause();
    
  }

  // purpose: notify app about adding friend, removing friend
  void listenForChanges() {
    listener = friendsCollectionRef.snapshots().listen((event) {
      for (var docChange in event.docChanges) {
        var doc = docChange.doc;
        switch (docChange.type) {
          case DocumentChangeType.added:
            friendsMap.value[doc.id] = doc.data() ?? {};
            friendsMap(friendsMap.value);
            break;
          case DocumentChangeType.removed:
            friendsMap.value.remove(doc.id);
            friendsMap(friendsMap.value);
            break;
          case DocumentChangeType.modified:
            // TODO: new features
            break;
        }
      }
      friendsMap.refresh();
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }
}
