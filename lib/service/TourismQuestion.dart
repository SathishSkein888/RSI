// // To parse this JSON data, do
// //
// //     final tourism = tourismFromJson(jsonString);

// import 'dart:convert';

// Tourism tourismFromJson(String str) => Tourism.fromJson(json.decode(str));

// String tourismToJson(Tourism data) => json.encode(data.toJson());

// class Tourism {
//     Tourism({
//         this.title,
//         this.question,
//     });

//     String title;
//     List<Question> question;

//     factory Tourism.fromJson(Map<String, dynamic> json) => Tourism(
//         title: json["title"],
//         question: List<Question>.from(json["question"].map((x) => Question.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "question": List<dynamic>.from(question.map((x) => x.toJson())),
//     };
// }

// class Question {
//     Question({
//         this.qus,
//         this.type,
//         this.choice,
//         this.ans,
//     });

//     String qus;
//     Type type;
//     List<String> choice;
//     dynamic ans;

//     factory Question.fromJson(Map<String, dynamic> json) => Question(
//         qus: json["qus"],
//         type: typeValues.map[json["type"]],
//         choice: json["choice"] == null ? null : List<String>.from(json["choice"].map((x) => x)),
//         ans: json["ans"],
//     );

//     Map<String, dynamic> toJson() => {
//         "qus": qus,
//         "type": typeValues.reverse[type],
//         "choice": choice == null ? null : List<dynamic>.from(choice.map((x) => x)),
//         "ans": ans,
//     };
// }

// enum Type { RADIO, TEXT, MULTITEXT }

// final typeValues = EnumValues({
//     "multitext": Type.MULTITEXT,
//     "radio": Type.RADIO,
//     "text": Type.TEXT
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }

// To parse this JSON data, do
//
//     final tourism = tourismFromJson(jsonString);

import 'dart:convert';

Tourism tourismFromJson(String str) => Tourism.fromJson(json.decode(str));

String tourismToJson(Tourism data) => json.encode(data.toJson());

class Tourism {
    Tourism({
        this.title,
        this.question,
    });

    String title;
    List<Question> question;

    factory Tourism.fromJson(Map<String, dynamic> json) => Tourism(
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
    String type;
    List<String> choice;
    String ans;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        qus: json["qus"],
        type: json["type"],
        choice: json["choice"] == null ? null : List<String>.from(json["choice"].map((x) => x)),
        ans: json["ans"],
    );

    Map<String, dynamic> toJson() => {
        "qus": qus,
        "type": type,
        "choice": choice == null ? null : List<dynamic>.from(choice.map((x) => x)),
        "ans": ans,
    };
}
