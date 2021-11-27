// To parse this JSON data, do
//
//     final getDeviceId = getDeviceIdFromJson(jsonString);

import 'dart:convert';

GetDeviceId getDeviceIdFromJson(String str) =>
    GetDeviceId.fromJson(json.decode(str));

String getDeviceIdToJson(GetDeviceId data) => json.encode(data.toJson());

class GetDeviceId {
  GetDeviceId({
    this.deviceId,
  });

  List<DeviceId> deviceId;

  factory GetDeviceId.fromJson(Map<String, dynamic> json) => GetDeviceId(
        deviceId: List<DeviceId>.from(
            json["device_id"].map((x) => DeviceId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "device_id": List<dynamic>.from(deviceId.map((x) => x.toJson())),
      };
}

class DeviceId {
  DeviceId({
    this.id,
    this.deviceId,
    this.createdAt,
  });

  int id;
  String deviceId;
  DateTime createdAt;

  factory DeviceId.fromJson(Map<String, dynamic> json) => DeviceId(
        id: json["id"],
        deviceId: json["device_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "created_at": createdAt.toIso8601String(),
      };
}
