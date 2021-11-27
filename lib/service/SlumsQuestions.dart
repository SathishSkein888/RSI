// To parse this JSON data, do
//
//     final slums = slumsFromJson(jsonString);

import 'dart:convert';

Slums slumsFromJson(String str) => Slums.fromJson(json.decode(str));

String slumsToJson(Slums data) => json.encode(data.toJson());

class Slums {
    Slums({
        this.title,
        this.question,
    });

    String title;
    List<Question> question;

    factory Slums.fromJson(Map<String, dynamic> json) => Slums(
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
        this.choice,
        this.ans,
    });

    String qus;
    Type type;
    List<String> choice;
    String ans;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: typeValues.map[json["type"]],
        choice: json["choice"] == null ? null : List<String>.from(json["choice"].map((x) => x)),
        ans: json["ans"] == null ? null : json["ans"],
    );

    Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": typeValues.reverse[type],
        "choice": choice == null ? null : List<dynamic>.from(choice.map((x) => x)),
        "ans": ans == null ? null : ans,
    };
}

enum Type { RADIO, RADIOWITHTEXT, TEXT, TABLE }

final typeValues = EnumValues({
    "radio": Type.RADIO,
    "radiowithtext": Type.RADIOWITHTEXT,
    "table": Type.TABLE,
    "text": Type.TEXT
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
