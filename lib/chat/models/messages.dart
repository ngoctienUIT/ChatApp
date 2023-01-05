import 'package:chat_app/chat/models/content_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  String sender;
  String? id;
  String? chatID;
  ContentMessages content;
  DateTime timestamp;
  bool delete;
  int? reaction;

  Messages({
    this.id,
    this.chatID,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.delete = false,
    this.reaction,
  });

  factory Messages.fromFirebase(DocumentSnapshot snapshot) {
    Timestamp time = snapshot["timestamp"];
    return Messages(
      id: snapshot.id,
      sender: snapshot["sender"],
      content: ContentMessages.fromMap(snapshot["content"]),
      timestamp:
          DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch),
      delete: snapshot["delete"],
      reaction: snapshot["reaction"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "content": content.toMap(),
      "timestamp": timestamp,
      "delete": delete,
      "reaction": reaction,
    };
  }
}
