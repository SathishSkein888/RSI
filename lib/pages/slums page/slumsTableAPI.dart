// To parse this JSON data, do
//
//     final slumsTableApi = slumsTableApiFromJson(jsonString);

import 'dart:convert';

SlumsTableApi slumsTableApiFromJson(String str) =>
    SlumsTableApi.fromJson(json.decode(str));

String slumsTableApiToJson(SlumsTableApi data) => json.encode(data.toJson());

class SlumsTableApi {
  SlumsTableApi({
    this.slumsId,
    this.whetherAllChildrenEnrolledInSchool,
    this.studentGender,
    this.typeOfSchool,
    this.notGoingDropoutAge,
    this.reasonOfDropout,
  });

  String  slumsId;
  String  whetherAllChildrenEnrolledInSchool;
  String  studentGender;
  String  typeOfSchool;
  String  notGoingDropoutAge;
  String  reasonOfDropout;

  factory SlumsTableApi.fromJson(Map<String, dynamic> json) => SlumsTableApi(
        slumsId: json["slums_id"],
        whetherAllChildrenEnrolledInSchool:
            json["whether_all_children_enrolled_in_school"],
        studentGender: json["student_gender"],
        typeOfSchool: json["type_of_school"],
        notGoingDropoutAge: json["not_going_dropout_age"],
        reasonOfDropout: json["reason_of_dropout"],
      );

  Map<String, dynamic> toJson() => {
        "slums_id": slumsId,
        "whether_all_children_enrolled_in_school":
            whetherAllChildrenEnrolledInSchool,
        "student_gender": studentGender,
        "type_of_school": typeOfSchool,
        "not_going_dropout_age": notGoingDropoutAge,
        "reason_of_dropout": reasonOfDropout,
      };
}
