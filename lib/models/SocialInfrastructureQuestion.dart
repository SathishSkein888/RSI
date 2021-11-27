// To parse this JSON data, do
//
//     final socialInfrastructure = socialInfrastructureFromJson(jsonString);

import 'dart:convert';

SocialInfrastructure socialInfrastructureFromJson(String str) =>
    SocialInfrastructure.fromJson(json.decode(str));

String socialInfrastructureToJson(SocialInfrastructure data) =>
    json.encode(data.toJson());

class SocialInfrastructure {
  SocialInfrastructure({
    this.title,
    this.question,
  });

  String title;
  List<Question> question;

  factory SocialInfrastructure.fromJson(Map<String, dynamic> json) =>
      SocialInfrastructure(
        title: json["title"],
        question: List<Question>.from(
            json["question"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "question": List<dynamic>.from(question.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.qus,
    this.type,
    this.mandatory,
    this.choice,
    this.ans,
  });

  String qus;
  Type type;
  Mandatory mandatory;
  List<String> choice;
  String ans;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: typeValues.map[json["type"]],
        mandatory: json["mandatory"] == null
            ? null
            : mandatoryValues.map[json["mandatory"]],
        choice: json["choice"] == null
            ? null
            : List<String>.from(json["choice"].map((x) => x)),
        ans: json["ans"],
      );

  Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": typeValues.reverse[type],
        "mandatory":
            mandatory == null ? null : mandatoryValues.reverse[mandatory],
        "choice":
            choice == null ? null : List<dynamic>.from(choice.map((x) => x)),
        "ans": ans,
      };
}

enum Mandatory { YES }

final mandatoryValues = EnumValues({"yes": Mandatory.YES});

enum Type { RADIO, RADIOWITHTEXT, TEXT, CHECKBOX, CHECKBOX1, CHECKBOX2 }

final typeValues = EnumValues({
  "radio": Type.RADIO,
  "radiowithtext": Type.RADIOWITHTEXT,
  "text": Type.TEXT,
  "checkbox": Type.CHECKBOX,
  "checkbox1": Type.CHECKBOX1,
  "checkbox2": Type.CHECKBOX2
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
