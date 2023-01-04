import 'package:chat_app/chat/models/content_messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowImageMessage extends StatelessWidget {
  const ShowImageMessage({Key? key, required this.content, required this.check})
      : super(key: key);

  final bool check;
  final ContentMessages content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: check ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: Get.width * 2 / 3),
            padding: const EdgeInsets.all(5),
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
              alignment: check ? WrapAlignment.end : WrapAlignment.start,
              children: List.generate(content.image!.length, (index) {
                if (content.image!.length > 2) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      content.image![index],
                      width: Get.width * 2 / 9 - 6,
                      height: Get.width * 2 / 9 - 6,
                      fit: BoxFit.fill,
                    ),
                  );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    content.image![index],
                    width: Get.width * 2 / (3 * content.image!.length) -
                        content.image!.length * 3,
                    height: Get.width * 2 / (3 * content.image!.length) -
                        content.image!.length * 3,
                    fit: BoxFit.fill,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
