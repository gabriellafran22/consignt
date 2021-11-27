import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.province,
    this.city,
    this.profilePicture,
    this.isSeller,
    this.createdUpdatedAt,
  });

  String? id;
  String? name;
  String? phoneNumber;
  String? province;
  String? city;
  String? profilePicture;
  bool? isSeller;
  String? createdUpdatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        province: json["province"],
        city: json["city"],
        profilePicture: json["profilePicture"],
        isSeller: json["isSeller"],
        createdUpdatedAt: json["createdUpdatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "province": province,
        "city": city,
        "profilePicture": profilePicture,
        "isSeller": isSeller,
        "createdUpdatedAt": createdUpdatedAt,
      };
}
