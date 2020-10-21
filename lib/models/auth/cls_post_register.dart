// To parse this JSON data, do
//
//     final modelPostEditRegisterPassword = modelPostEditRegisterPasswordFromJson(jsonString);

import 'dart:convert';

ModelPostEditRegisterPassword modelPostEditRegisterPasswordFromJson(String str) => ModelPostEditRegisterPassword.fromJson(json.decode(str));

String modelPostEditRegisterPasswordToJson(ModelPostEditRegisterPassword data) => json.encode(data.toJson());

class ModelPostEditRegisterPassword {
    ModelPostEditRegisterPassword({
        this.isRegister,
        this.email,
        this.password,
        this.namaDepan,
        this.namaBelakang,
    });

    bool isRegister;
    String email;
    String password;
    String namaDepan;
    String namaBelakang;

    factory ModelPostEditRegisterPassword.fromJson(Map<String, dynamic> json) => ModelPostEditRegisterPassword(
        isRegister: json["is_register"] == null ? null : json["is_register"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang: json["nama_belakang"] == null ? null : json["nama_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "is_register": isRegister == null ? null : isRegister,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
    };
}
