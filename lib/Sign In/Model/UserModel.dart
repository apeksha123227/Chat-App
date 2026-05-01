import 'dart:convert';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? image;
  String? phone;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.image,
    this.phone, //
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "image": image,
      "phone": phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      image: json["image"],
      phone: json["phone"],
    );
  }

  String encode() => jsonEncode(toJson());

  static UserModel decode(String user) => UserModel.fromJson(jsonDecode(user));
}
