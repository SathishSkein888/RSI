// To parse this JSON data, do
//
//     final transportation = transportationFromJson(jsonString);

import 'dart:convert';

Transportation transportationFromJson(String str) =>
    Transportation.fromJson(json.decode(str));

String transportationToJson(Transportation data) => json.encode(data.toJson());

class Transportation {
  Transportation({
    this.title,
    this.question,
  });

  String title;
  List<Question> question;

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
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

enum Type { RADIO, RADIO_WITH_TEXT, TEXT, CHECKBOX, CHECKBOX1 }

final typeValues = EnumValues({
  "radio": Type.RADIO,
  "radioWithText": Type.RADIO_WITH_TEXT,
  "text": Type.TEXT,
  "checkbox": Type.CHECKBOX,
  "checkbox1": Type.CHECKBOX1
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
