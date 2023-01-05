import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String? image;
  DateTime? lastSeen;
  String? token;
  bool isActive;
  bool notify;

  User({
    required this.id,
    required this.name,
    this.image,
    this.lastSeen,
    this.token,
    this.isActive = true,
    this.notify = true,
  });

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.id,
      name: snapshot["name"],
      image: snapshot["profile_picture"],
      lastSeen: DateTime.fromMicrosecondsSinceEpoch(
        (snapshot["last_seen"] as Timestamp).microsecondsSinceEpoch,
      ),
      token: snapshot["token"],
      isActive: snapshot["is_active"],
    );
  }

  static Future<User?> getInfoUser(String id) async {
    User? user;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) async {
      user = User.fromFirebase(value);
    });
    return user;
  }
}
