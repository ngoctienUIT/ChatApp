import 'dart:io';
import 'package:chat_app/auth/widgets/custom_button.dart';
import 'package:chat_app/auth/widgets/gender_widget.dart';
import 'package:chat_app/auth/widgets/show_birthday.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController(text: "Trần Ngọc Tiến");
  final addressController = TextEditingController(text: "Khánh Hòa");
  final phoneController = TextEditingController(text: "032124435");
  bool gender = true;
  File? image;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: const Text(
            "Account",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              InkWell(
                borderRadius: BorderRadius.circular(90),
                onTap: () async {
                  try {
                    var pickImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickImage == null) return;
                    final cropImage = await ImageCropper().cropImage(
                        sourcePath: pickImage.path,
                        aspectRatio:
                            const CropAspectRatio(ratioX: 1, ratioY: 1),
                        aspectRatioPresets: [CropAspectRatioPreset.square]);
                    if (cropImage == null) return;
                    setState(() => image = File(cropImage.path));
                  } on PlatformException catch (_) {}
                },
                child: Stack(
                  children: [
                    ClipOval(
                      child: image == null
                          ? Image.asset("assets/images/avatar.jpg", width: 170)
                          : Image.file(image!, width: 170),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Image.asset(
                        "assets/images/image.png",
                        width: 35,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textProfile("Full Name"),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    textProfile("Address"),
                    TextField(
                      controller: addressController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    textProfile("Phone Number"),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    textProfile("Birthday"),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() => selectedDate = picked);
                        }
                      },
                      child: showBirthday(selectedDate),
                    ),
                    const SizedBox(height: 30),
                    textProfile("Gender"),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Spacer(),
                        genderWidget(
                            currentGender: gender,
                            gender: true,
                            action: () {
                              if (!gender) {
                                setState(() => gender = true);
                              }
                            }),
                        const Spacer(),
                        genderWidget(
                            currentGender: gender,
                            gender: false,
                            action: () {
                              if (gender) {
                                setState(() => gender = false);
                              }
                            }),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(onPress: () {}, text: "Save")
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget textProfile(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
      ),
    );
  }
}
