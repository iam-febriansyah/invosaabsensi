// To parse this JSON data, do
//
//     final modelPostAbsen = modelPostAbsenFromJson(jsonString);

import 'dart:convert';

ModelPostAbsen modelPostAbsenFromJson(String str) =>
    ModelPostAbsen.fromJson(json.decode(str));

String modelPostAbsenToJson(ModelPostAbsen data) => json.encode(data.toJson());

class ModelPostAbsen {
  ModelPostAbsen({
    this.latitude,
    this.longitude,
    this.lokasi,
    this.inOut,
    this.isWfh,
    this.foto,
  });

  String latitude;
  String longitude;
  String lokasi;
  String inOut;
  String isWfh;
  String foto;

  factory ModelPostAbsen.fromJson(Map<String, dynamic> json) => ModelPostAbsen(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        lokasi: json["lokasi"] == null ? null : json["lokasi"],
        inOut: json["in_out"] == null ? null : json["in_out"],
        isWfh: json["is_wfh"] == null ? null : json["is_wfh"],
        foto: json["foto"] == null ? null : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "lokasi": lokasi == null ? null : lokasi,
        "in_out": inOut == null ? null : inOut,
        "is_wfh": isWfh == null ? null : isWfh,
        "foto": foto == null ? null : foto,
      };
}
