// To parse this JSON data, do
//
//     final modelHome = modelHomeFromJson(jsonString);

import 'dart:convert';

import 'package:absensi/models/menu/cls_absen.dart';

ModelHome modelHomeFromJson(String str) => ModelHome.fromJson(json.decode(str));

String modelHomeToJson(ModelHome data) => json.encode(data.toJson());

class ModelHome {
  ModelHome({
    this.statusJson,
    this.remarks,
    this.dataAbsenIn,
    this.dataAbsenOut,
  });

  bool statusJson;
  String remarks;
  DataAbsen dataAbsenIn;
  DataAbsen dataAbsenOut;

  factory ModelHome.fromJson(Map<String, dynamic> json) => ModelHome(
      statusJson: json["status_json"] == null ? null : json["status_json"],
      remarks: json["remarks"] == null ? null : json["remarks"],
      dataAbsenIn: json["data_absen_in"] == null
          ? null
          : DataAbsen.fromJson(json["data_absen_in"]),
      dataAbsenOut: json["data_absen_out"] == null
          ? null
          : DataAbsen.fromJson(json["data_absen_out"]));

  Map<String, dynamic> toJson() => {
        "status_json": statusJson == null ? null : statusJson,
        "remarks": remarks == null ? null : remarks,
        "data_absen_in": dataAbsenIn == null ? null : dataAbsenIn.toJson(),
        "data_absen_out": dataAbsenOut == null ? null : dataAbsenOut.toJson(),
      };
}
