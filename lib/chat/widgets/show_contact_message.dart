import 'dart:math';
import 'package:chat_app/chat/models/messages.dart';
import 'package:chat_app/chat/widgets/message_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowContactMessage extends StatelessWidget {
  const ShowContactMessage(
      {Key? key, required this.check, required this.messages})
      : super(key: key);

  final bool check;
  final Messages messages;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      messages: messages,
      check: check,
      child: InkWell(
        onTap: () {
          ContactsService.addContact(Contact(
            displayName: messages.content.nameContact,
            phones: [Item(value: messages.content.phoneContact!)],
          )).then((value) async {
            await Get.defaultDialog(
              title: "Thêm liên hệ thành công",
              content: Column(
                children: [
                  Text(
                    messages.content.nameContact!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    messages.content.phoneContact!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          });
        },
        child: Container(
          alignment: check ? Alignment.centerRight : Alignment.centerLeft,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.blue.shade400,
            child: SizedBox(
              height: 60,
              width: Get.width / 2,
              child: Row(
                children: [
                  const Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: const Color(0xff262626),
                    ),
                    child: Text(
                      messages.content.nameContact![0],
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          messages.content.nameContact!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          messages.content.phoneContact!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
