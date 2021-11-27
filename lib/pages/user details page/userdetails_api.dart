import 'dart:convert';

//UserDetailsApi userDetailsApiFromJson(String str) =>
//  UserDetailsApi.fromJson(json.decode(str));

//String userDetailsApiToJson(UserDetailsApi data) => json.encode(data.toJson());

class UserDetailsApi {
  UserDetailsApi({
    this.localityName,
    this.ward,
    this.totalNoOfMembers,
    this.familyHeadFullname,
    this.male,
    this.female,
    this.illetrateMember,
    this.caste,
    this.religion,
    this.minorityStatus,
  });
  @override
  String toString() {
    return 'UserDetailsApi: {localityName: ${localityName},'
        ' ward: ${ward},'
        'totalNoOfMembers: ${totalNoOfMembers},'
        'ward: ${ward},'
        'familyHeadFullname: ${familyHeadFullname},'
        'male: ${male},'
        'female: ${female},'
        'illetrateMember: ${illetrateMember},'
        'caste: ${caste},'
        'religion: ${religion},'
        'minorityStatus: ${minorityStatus},';
  }

  String localityName;
  String ward;
  String totalNoOfMembers;
  String familyHeadFullname;
  String male;
  String female;
  String illetrateMember;
  String caste;
  String religion;
  String minorityStatus;

  factory UserDetailsApi.fromJson(Map<String, dynamic> json) => UserDetailsApi(
        localityName: json["locality_name"],
        ward: json["ward"],
        totalNoOfMembers: json["total_no_of_members"],
        familyHeadFullname: json["family_head_fullname"],
        male: json["male"],
        female: json["female"],
        illetrateMember: json["illetrate_member"],
        caste: json["caste"],
        religion: json["religion"],
        minorityStatus: json["minority_status"],
      );

  static Map<String, dynamic> toJson(UserDetailsApi userDetailsApi) => {
        "locality_name": userDetailsApi.localityName,
        "ward": userDetailsApi.ward,
        "total_no_of_members": userDetailsApi.totalNoOfMembers,
        "family_head_fullname": userDetailsApi.familyHeadFullname,
        "male": userDetailsApi.male,
        "female": userDetailsApi.female,
        "illetrate_member": userDetailsApi.illetrateMember,
        "caste": userDetailsApi.caste,
        "religion": userDetailsApi.religion,
        "minority_status": userDetailsApi.minorityStatus,
      };
  static String encode(List<UserDetailsApi> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => UserDetailsApi.toJson(music))
            .toList(),
      );

  static List<UserDetailsApi> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<UserDetailsApi>((item) => UserDetailsApi.fromJson(item))
          .toList();
}
