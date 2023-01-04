import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/services/chat.dart';
import 'package:chat_app/chat/widgets/item_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OptionChat extends StatefulWidget {
  const OptionChat({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  State<OptionChat> createState() => _OptionChatState();
}

class _OptionChatState extends State<OptionChat> {
  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text =
        widget.chatRoom.user1.id == FirebaseAuth.instance.currentUser!.uid
            ? widget.chatRoom.user2.name
            : widget.chatRoom.user1.name;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onSelected: (value) {
        switch (value) {
          case 0:
            break;
          case 1:
            Get.defaultDialog(
              title: "Đổi biệt danh",
              content: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Hủy",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Ok",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
            break;
          case 2:
            break;
          case 3:
            deleteChat(widget.chatRoom.id, widget.chatRoom);
            Get.back();
            break;
          case 4:
            break;
        }
      },
      icon: const Icon(
        FontAwesomeIcons.ellipsisVertical,
        size: 20,
        color: Color.fromRGBO(34, 184, 190, 1),
      ),
      itemBuilder: (context) {
        return [
          itemPopup(
            text: 'Thông báo',
            icon: FontAwesomeIcons.solidBell,
            color: const Color.fromRGBO(59, 190, 253, 1),
            index: 0,
          ),
          itemPopup(
            text: 'Biệt danh',
            icon: FontAwesomeIcons.penToSquare,
            color: const Color.fromRGBO(59, 190, 253, 1),
            index: 1,
          ),
          itemPopup(
            text: 'Màu sắc',
            icon: FontAwesomeIcons.palette,
            color: const Color.fromRGBO(26, 191, 185, 1),
            index: 2,
          ),
          itemPopup(
            text: 'Xóa đoạn chat',
            icon: FontAwesomeIcons.trash,
            color: const Color.fromRGBO(255, 113, 150, 1),
            index: 3,
          ),
          itemPopup(
            text: 'Chặn',
            icon: FontAwesomeIcons.ban,
            color: const Color.fromRGBO(252, 177, 188, 1),
            index: 4,
          ),
        ];
      },
    );
  }
}
