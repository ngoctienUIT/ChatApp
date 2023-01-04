import 'package:chat_app/chat/models/content_messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowTextMessage extends StatelessWidget {
  const ShowTextMessage({Key? key, required this.check, required this.content})
      : super(key: key);
  final bool check;
  final ContentMessages content;

  @override
  Widget build(BuildContext context) {
    Offset tapPosition = Offset.zero;

    return GestureDetector(
      onTapDown: (details) {
        tapPosition = details.globalPosition;
      },
      onLongPress: () {
        showMenu(
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        print("0k");
                      },
                      child: const Text(
                        "❤",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "😯",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "😆",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "😢",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "😠",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "👍",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: Row(
                children: const [
                  Icon(Icons.delete),
                  Text("Delete"),
                ],
              ),
            )
          ],
        );
      },
      child: Container(
        alignment: check ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 2 / 3),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: check ? Colors.blue : Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    content.text!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
