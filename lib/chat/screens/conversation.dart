import 'dart:io';

import 'package:chat_app/chat/controllers/friend_item.dart';
import 'package:chat_app/chat/widgets/profile_picture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Conversation extends StatefulWidget {
  const Conversation.withFriend(this.friendId, {Key? key}): super(key: key);

  final String friendId;
  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool show = false;
  bool sendButton = false;
 // late FlutterSoundRecorder recorder = FlutterSoundRecorder();

  @override
  void initState() {
   // initRecorder();
    super.initState();
  }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw 'error';
  //   }
  //   await recorder.openRecorder();
  //   recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  // }

  @override
  void dispose() {
   //recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 25,
        // titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromRGBO(150, 150, 150, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            ProfilePicture(FriendItemControllers.inst.get(widget.friendId).userData['profile_picture']),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   FriendItemControllers.inst.get(widget.friendId).userData['name'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'active'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.phone,
              size: 20,
              color: Color.fromRGBO(34, 184, 190, 1),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.video,
              size: 20,
              color: Color.fromRGBO(34, 184, 190, 1),
            ),
          ),
          PopupMenuButton<int>(
            padding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onSelected: (value) {
              print(value);
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
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          if (show) {
            setState(() => show = false);
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: show ? MediaQuery.of(context).size.height * 0.4 : 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _controller,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              onTap: () {
                                if (show) {
                                  setState(() => show = !show);
                                }
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() => sendButton = true);
                                } else {
                                  setState(() => sendButton = false);
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    show
                                        ? Icons.keyboard
                                        : Icons.emoji_emotions_outlined,
                                  ),
                                  onPressed: () {
                                    if (!show) {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                    } else {
                                      focusNode.requestFocus();
                                    }
                                    setState(() => show = !show);
                                  },
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.attach_file),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) => bottomSheet(),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            right: 2,
                            left: 2,
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFF128C7E),
                            child: IconButton(
                              icon:const  Icon( Icons.send,
                                // sendButton
                                //     ? Icons.send
                                //     : (recorder.isRecording
                                //         ? Icons.stop
                                //         : Icons.mic),
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // if (sendButton) {
                                // } else if (recorder.isRecording) {
                                //   stop();
                                // } else {
                                //   record();
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: show ? 1 : 0,
                      child: show ? emojiSelect() : Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future stop() async {
  //   final path = await recorder.stopRecorder();
  //   final audio = File(path!);
  //   setState(() {});
  // }

  // Future record() async {
  //   await recorder.startRecorder(toFile: 'audio');
  //   setState(() {});
  // }

  PopupMenuItem<int> itemPopup({
    required String text,
    required int index,
    required IconData icon,
    required Color color,
  }) {
    return PopupMenuItem<int>(
      value: index,
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 7),
          Text(text)
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    "Document",
                    () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                    () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {}
                      } on PlatformException catch (_) {}
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    () async {
                      try {
                        List<XFile>? images =
                            await ImagePicker().pickMultiImage();
                      } catch (_) {}
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    "Audio",
                    () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['mp3', 'wav', 'aac'],
                      );

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.location_pin,
                    Colors.teal,
                    "Location",
                    () {},
                  ),
                  const SizedBox(width: 40),
                  iconCreation(
                    Icons.person,
                    Colors.blue,
                    "Contact",
                    () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, Function onPress) {
    return InkWell(
      onTap: () => onPress(),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icons, size: 29, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      textEditingController: _controller,
      config: Config(
        columns: 7,
        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        verticalSpacing: 0,
        horizontalSpacing: 0,
        gridPadding: EdgeInsets.zero,
        initCategory: Category.RECENT,
        bgColor: const Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        backspaceColor: Colors.blue,
        skinToneDialogBgColor: Colors.white,
        skinToneIndicatorColor: Colors.grey,
        enableSkinTones: true,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecents: const Text(
          'No Recents',
          style: TextStyle(fontSize: 20, color: Colors.black26),
          textAlign: TextAlign.center,
        ), // Needs to be const Widget
        loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}
