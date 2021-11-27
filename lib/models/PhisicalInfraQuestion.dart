// To parse this JSON data, do
//
//     final physicalInfrastructure = physicalInfrastructureFromJson(jsonString);

import 'dart:convert';

PhysicalInfrastructure physicalInfrastructureFromJson(String str) =>
    PhysicalInfrastructure.fromJson(json.decode(str));

String physicalInfrastructureToJson(PhysicalInfrastructure data) =>
    json.encode(data.toJson());

class PhysicalInfrastructure {
  PhysicalInfrastructure({
    this.title,
    this.question,
  });

  String title;
  List<Question> question;

  factory PhysicalInfrastructure.fromJson(Map<String, dynamic> json) =>
      PhysicalInfrastructure(
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
  Question({this.qus, this.type, this.choice, this.ans, this.inputVal});

  String qus;
  Type type;
  List<String> choice;
  String ans;
  String inputVal;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      qus: json["qus"],
      type: typeValues.map[json["type"]],
      choice: json["choice"] == null
          ? null
          : List<String>.from(json["choice"].map((x) => x)),
      ans: json["ans"],
      inputVal: json["inputVal"]);

  Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": typeValues.reverse[type],
        "choice":
            choice == null ? null : List<dynamic>.from(choice.map((x) => x)),
        "ans": ans,
        "inputVal": inputVal
      };
}

enum Type { RADIO, RADIOWITHTEXT, TEXT, CHECKBOX }

final typeValues = EnumValues({
  "radio": Type.RADIO,
  "radiowithtext": Type.RADIOWITHTEXT,
  "text": Type.TEXT,
  "checkbox": Type.CHECKBOX
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
