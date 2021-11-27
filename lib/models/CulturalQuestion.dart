// To parse this JSON data, do
//
//     final culturalHeritage = culturalHeritageFromJson(jsonString);

import 'dart:convert';

CulturalHeritage culturalHeritageFromJson(String str) =>
    CulturalHeritage.fromJson(json.decode(str));

String culturalHeritageToJson(CulturalHeritage data) =>
    json.encode(data.toJson());

class CulturalHeritage {
  CulturalHeritage({
    this.title,
    this.question,
  });

  String  title;
  List<Question>  question;

  factory CulturalHeritage.fromJson(Map<String, dynamic> json) =>
      CulturalHeritage(
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
  String  type;
  List<String>  choice;
  String  ans;
  String  inputVal;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: json["type"],
        choice: json["choice"] == null?
              null
            : List<String>.from(json["choice"].map((x) => x)),
        ans: json["ans"],
         inputVal: json["inputVal"]
      );

  Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": type,
        "choice":
            choice == null  ? null : List<dynamic>.from(choice .map((x) => x)),
        "ans": ans,
        "inputVal": inputVal
      };
}
