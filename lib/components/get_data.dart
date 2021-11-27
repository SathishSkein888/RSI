class DeviceId {
  bool status;
  List<Data> data;

  DeviceId({this.status, this.data});

  DeviceId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String surveyId;

  Data({this.surveyId});

  Data.fromJson(Map<String, dynamic> json) {
    surveyId = json['survey_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_id'] = this.surveyId;
    return data;
  }
}
