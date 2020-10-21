// To parse this JSON data, do
//
//     final modelReturnLogin = modelReturnLoginFromJson(jsonString);

import 'dart:convert';

ModelReturnLogin modelReturnLoginFromJson(String str) =>
    ModelReturnLogin.fromJson(json.decode(str));

String modelReturnLoginToJson(ModelReturnLogin data) =>
    json.encode(data.toJson());

class ModelReturnLogin {
  ModelReturnLogin({
    this.statusJson,
    this.remarks,
    this.token,
    this.dataUser,
  });

  bool statusJson;
  String remarks;
  String token;
  DataUser dataUser;

  factory ModelReturnLogin.fromJson(Map<String, dynamic> json) =>
      ModelReturnLogin(
        statusJson: json["status_json"] == null ? null : json["status_json"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        token: json["token"] == null ? null : json["token"],
        dataUser: json["data_user"] == null
            ? null
            : DataUser.fromJson(json["data_user"]),
      );

  Map<String, dynamic> toJson() => {
        "status_json": statusJson == null ? null : statusJson,
        "remarks": remarks == null ? null : remarks,
        "token": token == null ? null : token,
        "data_user": dataUser == null ? null : dataUser.toJson(),
      };
}

class DataUser {
  DataUser({
    this.iduser,
    this.email,
    this.password,
    this.namaDepan,
    this.namaBelakang,
    this.token,
  });

  String iduser;
  String email;
  String password;
  String namaDepan;
  String namaBelakang;
  String token;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        iduser: json["iduser"] == null ? null : json["iduser"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser == null ? null : iduser,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "token": token == null ? null : token,
      };
}
