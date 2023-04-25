// To parse this JSON data, do
//
//     final addPaymentModel = addPaymentModelFromJson(jsonString);

import 'dart:convert';

AddPaymentModel addPaymentModelFromJson(String str) =>
    AddPaymentModel.fromJson(json.decode(str));

String addPaymentModelToJson(AddPaymentModel data) =>
    json.encode(data.toJson());

class AddPaymentModel {
  AddPaymentModel({
    required this.status,
    required this.data,
  });

  String status;
  String data;

  factory AddPaymentModel.fromJson(Map<String, dynamic> json) =>
      AddPaymentModel(
        status: json["status"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}
