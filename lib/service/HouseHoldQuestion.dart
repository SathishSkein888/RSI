// To parse this JSON data, do
//
//     final houseHold = houseHoldFromJson(jsonString);

import 'dart:convert';

HouseHold houseHoldFromJson(String str) => HouseHold.fromJson(json.decode(str));

String houseHoldToJson(HouseHold data) => json.encode(data.toJson());

class HouseHold {
  HouseHold({
    this.title,
    this.question,
  });

  String title;
  List<Question> question;

  factory HouseHold.fromJson(Map<String, dynamic> json) => HouseHold(
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
    this.choices,
    this.ans,
    this.selected,
    this.subqunts,
    this.subqus,
  });

  String qus;
  String type;
  List<String> choices;
  String ans;
  bool selected;
  List<Question> subqunts;
  bool subqus;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: json["type"],
        choices: List<String>.from(json["choices"].map((x) => x)),
        ans: json["ans"] == null ? null : json["ans"],
        selected: json["selected"] == null ? null : json["selected"],
        subqunts: json["subqunts"] == null
            ? null
            : List<Question>.from(
                json["subqunts"].map((x) => Question.fromJson(x))),
        subqus: json["subqus"] == null ? null : json["subqus"],
      );

  Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": type,
        "choices": List<dynamic>.from(choices.map((x) => x)),
        "ans": ans == null ? null : ans,
        "selected": selected == null ? null : selected,
        "subqunts": subqunts == null
            ? null
            : List<dynamic>.from(subqunts.map((x) => x.toJson())),
        "subqus": subqus == null ? null : subqus,
      };
}
