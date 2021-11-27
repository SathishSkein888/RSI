// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

HouseHoldPost userPostFromJson(String str) => HouseHoldPost.fromJson(json.decode(str));

String userPostToJson(HouseHoldPost data) => json.encode(data.toJson());

class HouseHoldPost {
  HouseHoldPost({
    this.deviceId,
    this.userId,
    this.question,
    this.answer,
  });

  String deviceId;
  String userId;
  String question;
  String answer;

  factory HouseHoldPost.fromJson(Map<String, dynamic> json) => HouseHoldPost(
        deviceId: json["device_id"],
        userId: json["user_id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "user_id": userId,
        "question": question,
        "answer": answer,
      };
}
