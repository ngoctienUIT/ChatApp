import 'package:chat_app/chat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  User user1;
  User user2;
  String theme;
  String mainReaction;

  ChatRoom({
    required this.user1,
    required this.user2,
    required this.theme,
    required this.mainReaction,
  });

  factory ChatRoom.fromFirebase(DocumentSnapshot snapshot) {
    Map<String, dynamic> mapUser1 = snapshot["user1"];
    Map<String, dynamic> mapUser2 = snapshot["user2"];
    return ChatRoom(
      user1: User(
        id: mapUser1["id"],
        name: mapUser1["nick_name"],
      ),
      user2: User(
        id: mapUser2["id"],
        name: mapUser2["nick_name"],
      ),
      theme: snapshot["theme"],
      mainReaction: snapshot["main_reaction"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user1": {"id": user1.id, "nick_name": user1.name},
      "user2": {"id": user2.id, "nick_name": user2.name},
      "theme": theme,
      "main_reaction": mainReaction,
    };
  }
}
