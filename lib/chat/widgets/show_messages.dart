import 'package:chat_app/chat/widgets/show_file_message.dart';
import 'package:chat_app/chat/widgets/show_image_message.dart';
import 'package:chat_app/chat/widgets/show_text_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/messages.dart';

class ShowMessages extends StatelessWidget {
  const ShowMessages({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("private_chats")
            .doc(id)
            .collection("chats")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Messages> messages = [];
            for (var element in snapshot.requireData.docs) {
              messages.add(Messages.fromFirebase(element));
            }
            return SingleChildScrollView(
              reverse: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool check = messages[index].sender.compareTo(
                          FirebaseAuth.instance.currentUser!.uid.toString()) ==
                      0;

                  switch (messages[index].content.activity) {
                    case 0:
                      break;
                    case 1:
                      return ShowFileMessage(
                        check: check,
                        content: messages[index].content,
                      );
                    case 2:
                      return ShowImageMessage(
                        check: check,
                        content: messages[index].content,
                      );
                    case 3:
                      break;
                    case 4:
                      break;
                    case 5:
                      return ShowTextMessage(
                        check: check,
                        content: messages[index].content,
                      );
                    default:
                      return Container();
                  }
                  return Container();
                },
              ),
            );
          }
          return Expanded(child: Container());
        });
  }
}
