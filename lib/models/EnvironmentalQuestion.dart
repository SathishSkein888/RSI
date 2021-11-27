// To parse this JSON data, do
//
//     final environmentalRelated = environmentalRelatedFromJson(jsonString);

import 'dart:convert';

EnvironmentalRelated environmentalRelatedFromJson(String str) =>
    EnvironmentalRelated.fromJson(json.decode(str));

String environmentalRelatedToJson(EnvironmentalRelated data) =>
    json.encode(data.toJson());

class EnvironmentalRelated {
  EnvironmentalRelated({
    this.title,
    this.question,
  });

  String  title;
  List<Question>  question;

  factory EnvironmentalRelated.fromJson(Map<String, dynamic> json) =>
      EnvironmentalRelated(
        title: json["title"],
        question: List<Question>.from(
            json["question"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "question": List<dynamic>.from(question .map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.qus,
    this.type,
    this.choice,
    this.ans,
     this.inputVal
  });

  String  qus;
  Type  type;
  List<String>  choice;
  String  ans;
  String  inputVal;




  factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: typeValues.map [json["type"]],
        choice: json["choice"] == null?
              null
            : List<String>.from(json["choice"].map((x) => x)),
        ans: json["ans"],
        inputVal: json["inputVal"]
      );

  Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": typeValues.reverse[type],
        "choice":
            choice == null ?  null : List<dynamic>.from(choice .map((x) => x)),
        "ans": ans,
        "inputVal": inputVal
      };
}

enum Type { RADIO, TEXT, RADIOWITHTEXT }

final typeValues = EnumValues({
  "radio": Type.RADIO,
  "radiowithtext": Type.RADIOWITHTEXT,
  "text": Type.TEXT
});

class EnumValues<T> {
  Map<String, T>  map;
  Map<T, String>  reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map .map((k, v) => new MapEntry(v, k));
    }
    return reverseMap ;
  }
}
