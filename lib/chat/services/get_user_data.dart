import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: set user active
void loadUserData(Function onGetSuccess) async {
  // create user data if null
  final users = FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser!.uid.toString();

  final doc = await users.doc(userId).get().catchError((e) {
    Get.snackbar('Error loading user data', 'Please try again');
  });

  if (!doc.exists) {
    //create user data
    users.doc(userId).set({'friends': []}).then((value) {
      onGetSuccess();
    }).catchError((e) {
      Get.snackbar('Error creating user data', 'Please try again');
    });
  } else {
    onGetSuccess();
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
  final users = FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser!.uid.toString();

  return await users.doc(userId).get();
}
