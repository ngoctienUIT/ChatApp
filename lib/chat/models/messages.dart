import 'package:chat_app/chat/models/content_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  String sender;
  ContentMessages content;
  DateTime timestamp;

  Messages({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory Messages.fromFirebase(DocumentSnapshot snapshot) {
    Timestamp time = snapshot["timestamp"];
    return Messages(
      sender: snapshot["sender"],
      content: ContentMessages.fromMap(snapshot["content"]),
      timestamp:
          DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "content": content.toMap(),
      "timestamp": timestamp,
    };
  }
}
