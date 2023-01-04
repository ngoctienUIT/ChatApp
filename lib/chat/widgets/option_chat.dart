import 'package:chat_app/chat/models/chat_room.dart';
import 'package:chat_app/chat/services/chat.dart';
import 'package:chat_app/chat/widgets/item_popup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OptionChat extends StatelessWidget {
  const OptionChat({Key? key, required this.id, required this.chatRoom})
      : super(key: key);

  final String id;
  final ChatRoom chatRoom;

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
            break;
          case 2:
            deleteChat(id, chatRoom);
            Get.back();
            break;
          case 3:
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
            text: 'Màu sắc',
            icon: FontAwesomeIcons.palette,
            color: const Color.fromRGBO(26, 191, 185, 1),
            index: 1,
          ),
          itemPopup(
            text: 'Xóa đoạn chat',
            icon: FontAwesomeIcons.trash,
            color: const Color.fromRGBO(255, 113, 150, 1),
            index: 2,
          ),
          itemPopup(
            text: 'Chặn',
            icon: FontAwesomeIcons.ban,
            color: const Color.fromRGBO(252, 177, 188, 1),
            index: 3,
          ),
        ];
      },
    );
  }
}
