// To parse this JSON data, do
//
//     final housing = housingFromJson(jsonString);

import 'dart:convert';

Housing housingFromJson(String str) => Housing.fromJson(json.decode(str));

String housingToJson(Housing data) => json.encode(data.toJson());

class Housing {
    Housing({
        this.title,
        this.question,
    });

    String title;
    List<Question> question;

    factory Housing.fromJson(Map<String, dynamic> json) => Housing(
        title: json["title"],
        question: List<Question>.from(json["question"].map((x) => Question.fromJson(x))),
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
        this.subqunts,
        this.selected,
    });

    String qus;
    String type;
    List<String> choices;
    String ans;
    List<Subqunt> subqunts;
    List<bool> selected;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: json["type"],
        choices: json["choices"] == null ? null : List<String>.from(json["choices"].map((x) => x)),
        ans: json["ans"] == null ? null : json["ans"],
        subqunts: json["subqunts"] == null ? null : List<Subqunt>.from(json["subqunts"].map((x) => Subqunt.fromJson(x))),
        selected: json["selected"] == null ? null : List<bool>.from(json["selected"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": type,
        "choices": choices == null ? null : List<dynamic>.from(choices.map((x) => x)),
        "ans": ans == null ? null : ans,
        "subqunts": subqunts == null ? null : List<dynamic>.from(subqunts.map((x) => x.toJson())),
        "selected": selected == null ? null : List<dynamic>.from(selected.map((x) => x)),
    };
}

class Subqunt {
    Subqunt({
        this.qus,
        this.type,
        this.subqus,
        this.choices,
        this.ans,
    });

    String qus;
    String type;
    bool subqus;
    List<String> choices;
    String ans;

    factory Subqunt.fromJson(Map<String, dynamic> json) => Subqunt(
        qus: json["qus"],
        type: json["type"],
        subqus: json["subqus"],
        choices: List<String>.from(json["choices"].map((x) => x)),
        ans: json["ans"],
    );

    Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": type,
        "subqus": subqus,
        "choices": List<dynamic>.from(choices.map((x) => x)),
        "ans": ans,
    };
}
