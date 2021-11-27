// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

UserPost userPostFromJson(String str) => UserPost.fromJson(json.decode(str));

String userPostToJson(UserPost data) => json.encode(data.toJson());

class UserPost {
  UserPost({
    this.city,
    this.deviceId,
    this.surveyId,
    this.question,
    this.answer,
  });
  String city;
  String deviceId;
  String surveyId;
  String question;
  String answer;

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
        city: json["city"],
        deviceId: json["device_id"],
        surveyId: json["survey_id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "device_id": deviceId,
        "survey_id": surveyId,
        "question": question,
        "answer": answer,
      };
}
