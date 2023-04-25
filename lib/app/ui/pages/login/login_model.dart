// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.data,
    required this.id,
    required this.profile,
    required this.username,
  });

  String status;
  String data;
  int id;
  int profile;
  String username;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"],
        id: json["id"],
        profile: json["profile"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "id": id,
        "profile": profile,
        "username": username,
      };
}
