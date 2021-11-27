class UserFields {
  static final String id = 'ID';
  static final String nameLocality = 'Name of Locality';
  static final String ward = 'Ward';
  static final String totalMember = 'Total No of Member';
  static final String familHeadFullName = 'Full Name of Family head';
  static final String male = 'Male';
  static final String female = 'Female';
  static final String member = 'Illiterate Member';
  static final String caste = 'Caste';
  static final String religion = 'Religion';
  static final String minorityStatus = 'Minority Status';
  static List<dynamic> ans = [];
  static List<String> getFields() => [
        id,
        nameLocality,
        ward,
        totalMember,
        familHeadFullName,
        male,
        female,
        member,
        caste,
        religion,
        minorityStatus
      ];
}
