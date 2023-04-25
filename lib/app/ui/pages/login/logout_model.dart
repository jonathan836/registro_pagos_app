// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(String str) =>
    LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  LogoutModel({
    required this.status,
  });

  String status;

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
