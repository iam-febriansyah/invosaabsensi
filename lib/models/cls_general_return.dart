// To parse this JSON data, do
//
//     final modelGeneralReturn = modelGeneralReturnFromJson(jsonString);

import 'dart:convert';

ModelGeneralReturn modelGeneralReturnFromJson(String str) =>
    ModelGeneralReturn.fromJson(json.decode(str));

String modelGeneralReturnToJson(ModelGeneralReturn data) =>
    json.encode(data.toJson());

class ModelGeneralReturn {
  ModelGeneralReturn({
    this.statusJson,
    this.remarks,
    this.setting,
  });

  bool statusJson;
  String remarks;
  Setting setting;

  factory ModelGeneralReturn.fromJson(Map<String, dynamic> json) =>
      ModelGeneralReturn(
        statusJson: json["status_json"] == null ? null : json["status_json"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        setting:
            json["setting"] == null ? null : Setting.fromJson(json["setting"]),
      );

  Map<String, dynamic> toJson() => {
        "status_json": statusJson == null ? null : statusJson,
        "remarks": remarks == null ? null : remarks,
        "setting": setting == null ? null : setting.toJson(),
      };
}

class Setting {
  Setting({
    this.idsetting,
    this.latitude,
    this.longitude,
    this.alamat,
    this.maps,
    this.maxJarak,
  });

  String idsetting;
  String latitude;
  String longitude;
  String alamat;
  String maps;
  String maxJarak;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        idsetting: json["idsetting"] == null ? null : json["idsetting"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        maps: json["maps"] == null ? null : json["maps"],
        maxJarak: json["max_jarak"] == null ? null : json["max_jarak"],
      );

  Map<String, dynamic> toJson() => {
        "idsetting": idsetting == null ? null : idsetting,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "alamat": alamat == null ? null : alamat,
        "maps": maps == null ? null : maps,
        "max_jarak": maxJarak == null ? null : maxJarak,
      };
}
