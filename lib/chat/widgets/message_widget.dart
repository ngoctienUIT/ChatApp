import 'package:chat_app/chat/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

List<String> react = ["❤", "😯", "😆", "😢", "😠", "👍"];

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.child,
    required this.check,
    required this.messages,
  }) : super(key: key);

  final Widget child;
  final bool check;
  final Messages messages;

  @override
  Widget build(BuildContext context) {
    Offset tapPosition = Offset.zero;

    return GestureDetector(
      onTapDown: (details) => tapPosition = details.globalPosition,
      onLongPress: () {
        showMenu(
          elevation: 0,
          color: Colors.transparent,
          context: context,
          position: RelativeRect.fromLTRB(
            check ? tapPosition.dx : 0,
            tapPosition.dy + 20,
            check ? 0 : tapPosition.dx,
            0,
          ),
          items: <PopupMenuEntry>[
            PopupMenuItem(
              onTap: null,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(react.length, (index) {
                      return InkWell(
                        onTap: () {
                          int? reaction;
                          if (!(messages.reaction != null &&
                              messages.reaction! == index)) {
                            reaction = index;
                          }
                          FirebaseFirestore.instance
                              .collection("private_chats")
                              .doc(messages.chatID)
                              .collection("chats")
                              .doc(messages.id)
                              .update({"reaction": reaction});
                          Get.back();
                        },
                        child: Text(
                          react[index],
                          style: const TextStyle(fontSize: 30),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: "test"));
              },
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.copy),
                      Text("Copy", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("private_chats")
                    .doc(messages.chatID)
                    .collection("chats")
                    .doc(messages.id)
                    .update({"delete": true});
              },
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete),
                      Text("Delete", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
      child: Row(
        children: [
          if (check) Expanded(child: Container()),
          Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: messages.reaction != null ? 8 : 0),
                child: child,
              ),
              if (messages.reaction != null)
                Positioned(
                  left: check ? 7 : null,
                  right: check ? null : 7,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      react[messages.reaction!],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
          if (!check) Expanded(child: Container()),
        ],
      ),
    );
  }
}
