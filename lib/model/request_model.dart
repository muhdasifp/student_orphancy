import 'package:care_life/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String? id;
  String? message;
  String? oldHome;
  UserModel? user;

  RequestModel({
    this.id,
    this.oldHome,
    this.message,
    this.user,
  });

  factory RequestModel.fromJson(DocumentSnapshot json) {
    final uid = json.id;
    return RequestModel(
      id: uid,
      oldHome: json['old_home'],
      message: json['message'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "old_home": oldHome ?? "",
        "message": message ?? "",
        "user": user!.toJson(),
      };
}
