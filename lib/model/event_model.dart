import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? title;
  String? venue;
  String? time;
  String? date;
  String? description;

  EventModel({
    this.id,
    this.title,
    this.venue,
    this.time,
    this.date,
    this.description,
  });

  factory EventModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return EventModel(
      id: document.id,
      title: json["title"],
      venue: json["venue"],
      time: json["time"],
      date: json["date"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "title": title ?? "",
        "venue": venue ?? "",
        "time": time ?? "",
        "date": date ?? "",
        "description": description ?? "",
      };
}
