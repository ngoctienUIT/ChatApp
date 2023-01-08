import 'package:cloud_firestore/cloud_firestore.dart';

class ContentMessages {
  int activity; //0: callDuration, 1: file, 2: image, 3: recording, 4: sticker, 5: text
  DateTime? callDuration;
  String? file;
  List<String>? image;
  String? recording;
  String? sticker;
  String? text;
  DateTime? seen;

  ContentMessages({
    required this.activity,
    this.callDuration,
    this.file,
    this.image,
    this.sticker,
    this.recording,
    this.text,
    this.seen,
  });

  factory ContentMessages.fromMap(Map<String, dynamic> data) {
    Timestamp? timestamp = data["call_duration"];
    return ContentMessages(
      activity: data["activity"],
      callDuration: timestamp != null
          ? DateTime.fromMicrosecondsSinceEpoch(
              timestamp.microsecondsSinceEpoch)
          : null,
      text: data["text"],
      sticker: data["sticker"],
      recording: data["recording"],
      file: data["file"],
      image: ((data["image"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      seen: data["seen"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "activity": activity,
      "call_duration": callDuration,
      "file": file,
      "image": image,
      "sticker": sticker,
      "text": text,
      "recording": recording,
      "seen": seen,
    };
  }
}
