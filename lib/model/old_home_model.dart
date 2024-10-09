import 'package:cloud_firestore/cloud_firestore.dart';

class OldHomeModel {
  String? id;
  String? name;
  String? image;
  String? needs;
  String? number;
  String? type;
  String? mail;
  String? lat;
  String? long;
  String? address;

  OldHomeModel({
    this.id,
    this.name,
    this.image,
    this.needs,
    this.number,
    this.type,
    this.mail,
    this.lat,
    this.long,
    this.address,
  });

  factory OldHomeModel.fromJson(DocumentSnapshot json) {
    final id = json.id;
    return OldHomeModel(
      id: id,
      name: json["name"],
      image: json["image"],
      needs: json["needs"],
      number: json["number"],
      type: json["type"],
      mail: json["mail"],
      lat: json["lat"],
      long: json["long"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "name": name ?? "",
        "image": image ?? "",
        "needs": needs ?? "",
        "number": number ?? "",
        "type": type ?? "",
        "mail": mail ?? "",
        "lat": lat ?? "",
        "long": long ?? "",
        "address": address ?? "",
      };
}
