import 'dart:convert';

class UserModel {

  String? uid;
  String? name;
  String? email;
  String? image;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "image": image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      image: json["image"],
    );
  }

  String encode() => jsonEncode(toJson());

  static UserModel decode(String user) =>
      UserModel.fromJson(jsonDecode(user));
}