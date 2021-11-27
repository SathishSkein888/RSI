class DbModel {
  int id;
  String city;
  String surveyId;
  String question;
  String answer;
  DbModel({this.question, this.answer, this.surveyId, this.city, this.id});
  @override
  String toString() {
    return 'DbModel:{id:$id},{surveyId:$surveyId},{surveyId:$city},{question:$question},{answer:$answer}';
  }

  DbModel.withId(
      {this.id, this.surveyId, this.city, this.question, this.answer});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['city'] = city;
    map['surveyId'] = surveyId;
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

  factory DbModel.fromMap(Map<String, dynamic> map) {
    return DbModel.withId(
      id: map['id'],
      city: map['city'],
      surveyId: map['surveyId'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}
