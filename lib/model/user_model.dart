import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? lat;
  String? long;
  String? address;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.lat,
    this.long,
    this.address,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return UserModel(
      uid: document.id,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      phone: json["phone"] ?? "",
      lat: json["lat"] ?? "",
      long: json["long"] ?? "",
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid ?? "",
        "name": name ?? "",
        "email": email ?? "",
        "password": password ?? "",
        "phone": phone ?? "",
        "lat": lat ?? "",
        "long": long ?? "",
        "address": address ?? "",
      };
}
