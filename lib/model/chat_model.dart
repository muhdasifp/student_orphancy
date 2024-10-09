import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? sender;
  Timestamp? time;
  String? message;

  ChatModel({
    this.id,
    this.sender,
    this.time,
    this.message,
  });

  factory ChatModel.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return ChatModel(
      id: doc.id,
      sender: json["sender"],
      time: json["time"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "sender": sender ?? "",
        "time": time ?? "",
        "message": message ?? "",
      };
}
