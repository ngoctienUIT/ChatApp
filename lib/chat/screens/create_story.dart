import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CreateStory extends StatelessWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child:ElevatedButton(onPressed: _pickFile, child: Text('Pick file')));
  }
}

void _pickFile()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null){
    File file = File(result.files.single.path!);
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child("${FirebaseAuth.instance.currentUser!.uid}/${DateTime.now()}.mp4");
    await mountainsRef.putFile(file);
  }
}