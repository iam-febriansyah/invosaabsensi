// To parse this JSON data, do
//
//     final modelAbsensi = modelAbsensiFromJson(jsonString);

import 'dart:convert';

ModelAbsensi modelAbsensiFromJson(String str) =>
    ModelAbsensi.fromJson(json.decode(str));

String modelAbsensiToJson(ModelAbsensi data) => json.encode(data.toJson());

class ModelAbsensi {
  ModelAbsensi({
    this.statusJson,
    this.remarks,
    this.dataAbsen,
  });

  bool statusJson;
  String remarks;
  List<DataAbsen> dataAbsen;

  factory ModelAbsensi.fromJson(Map<String, dynamic> json) => ModelAbsensi(
        statusJson: json["status_json"] == null ? null : json["status_json"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        dataAbsen: json["data_absen"] == null
            ? null
            : List<DataAbsen>.from(
                json["data_absen"].map((x) => DataAbsen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_json": statusJson == null ? null : statusJson,
        "remarks": remarks == null ? null : remarks,
        "data_absen": dataAbsen == null
            ? null
            : List<dynamic>.from(dataAbsen.map((x) => x.toJson())),
      };
}

class DataAbsen {
  DataAbsen({
    this.idabsensi,
    this.iduser,
    this.namaDepan,
    this.namaBelakang,
    this.tanggal,
    this.jam,
    this.latitude,
    this.longitude,
    this.lokasi,
    this.inOut,
    this.isWfh,
    this.foto,
  });

  String idabsensi;
  String iduser;
  String namaDepan;
  String namaBelakang;
  String tanggal;
  String jam;
  String latitude;
  String longitude;
  String lokasi;
  String inOut;
  String isWfh;
  String foto;

  factory DataAbsen.fromJson(Map<String, dynamic> json) => DataAbsen(
        idabsensi: json["idabsensi"] == null ? null : json["idabsensi"],
        iduser: json["iduser"] == null ? null : json["iduser"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        tanggal: json["tanggal"] == null ? null : json["tanggal"],
        jam: json["jam"] == null ? null : json["jam"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        lokasi: json["lokasi"] == null ? null : json["lokasi"],
        inOut: json["in_out"] == null ? null : json["in_out"],
        isWfh: json["is_wfh"] == null ? null : json["is_wfh"],
        foto: json["foto"] == null ? null : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "idabsensi": idabsensi == null ? null : idabsensi,
        "iduser": iduser == null ? null : iduser,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "tanggal": tanggal == null ? null : tanggal,
        "jam": jam == null ? null : jam,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "lokasi": lokasi == null ? null : lokasi,
        "in_out": inOut == null ? null : inOut,
        "is_wfh": isWfh == null ? null : isWfh,
        "foto": isWfh == null ? null : foto,
      };
}
