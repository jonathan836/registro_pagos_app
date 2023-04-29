// To parse this JSON data, do
//
//     final getPaymentModel = getPaymentModelFromJson(jsonString);

import 'dart:convert';

GetPaymentModel getPaymentModelFromJson(String str) =>
    GetPaymentModel.fromJson(json.decode(str));

String getPaymentModelToJson(GetPaymentModel data) =>
    json.encode(data.toJson());

class GetPaymentModel {
  String status;
  List<Datum> data;

  GetPaymentModel({
    required this.status,
    required this.data,
  });

  factory GetPaymentModel.fromJson(Map<String, dynamic> json) =>
      GetPaymentModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String? apartment;
  String name;
  String amount;
  DateTime paymentDate;

  Datum({
    required this.id,
    this.apartment,
    required this.name,
    required this.amount,
    required this.paymentDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        apartment: json["apartment"],
        name: json["name"],
        amount: json["amount"],
        paymentDate: DateTime.parse(json["payment_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "apartment": apartment,
        "name": name,
        "amount": amount,
        "payment_date": paymentDate.toIso8601String(),
      };
}
