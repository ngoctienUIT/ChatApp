import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String? image;
  DateTime? lastSeen;
  String? token;

  User({
    required this.id,
    required this.name,
    this.image,
    this.lastSeen,
    this.token,
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
