class ContentMessages {
  String activity;
  DateTime? callDuration;
  String? file;
  String? recording;
  String? sticker;
  String? text;

  ContentMessages({
    required this.activity,
    this.callDuration,
    this.file,
    this.sticker,
    this.recording,
    this.text,
  });

  factory ContentMessages.fromMap(Map<String, dynamic> data) {
    return ContentMessages(
      activity: data["activity"],
      callDuration: data["call_duration"],
      text: data["text"],
      sticker: data["sticker"],
      recording: data["recording"],
      file: data["file"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "activity": activity,
      "callDuration": callDuration,
      "file": file,
      "sticker": sticker,
      "text": text,
      "recording": recording,
    };
  }
}
