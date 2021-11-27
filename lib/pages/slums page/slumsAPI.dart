// To parse this JSON data, do
//
//     final slumsApi = slumsApiFromJson(jsonString);

import 'dart:convert';

SlumsApi slumsApiFromJson(String str) => SlumsApi.fromJson(json.decode(str));

String slumsApiToJson(SlumsApi data) => json.encode(data.toJson());

class SlumsApi {
  SlumsApi({
    this.userId,
    this.thisPlaceIsAllottedToYouByAnyAuthority,
    this.statusOfLand,
    this.isTherePatta,
    this.howLongHaveYouStayedHere,
    this.typesOfWorkYouAreEngaged,
    this.areYouSkilledLabour,
    this.skillType,
    this.dueToCovid19YourIncomeJobBeenAffected,
    this.getAnyRationAssistanceFromGovernment,
    this.typeOfRationCardYouAvail,
    this.getAnyFinancialAssitanceFromGovernment,
    this.getAnyBenefitsFromAnyStateCentralHousingSchemes,
    this.allottedAnyHouseUnderTheSlumRehabilitationProject,
    this.ifGovernmentProvidesHouseYouMoveToThatPlace,
    this.getAnyBenefitsOfSwasthyaSathi,
    this.willingToGoBackToNativeIfSuitableJobsMadeAvailable,
    this.lifeInSlumAreas,
    this.kindOfProblemDoYouFace,
    this.faceAnyProblemsFromIndustriesAroundYou,
    this.whetherAllChildrenEnrolledInSchool,
    this.studentGender,
    this.typeOfSchool,
    this.notGoingDropoutAge,
    this.reasonOfDropout,
    this.suggestionForImprovement,
  });

  String  userId;
  String  thisPlaceIsAllottedToYouByAnyAuthority;
  String  statusOfLand;
  String  isTherePatta;
  String  howLongHaveYouStayedHere;
  String  typesOfWorkYouAreEngaged;
  String  areYouSkilledLabour;
  String  skillType;
  String  dueToCovid19YourIncomeJobBeenAffected;
  String  getAnyRationAssistanceFromGovernment;
  String  typeOfRationCardYouAvail;
  String  getAnyFinancialAssitanceFromGovernment;
  String  getAnyBenefitsFromAnyStateCentralHousingSchemes;
  String  allottedAnyHouseUnderTheSlumRehabilitationProject;
  String  ifGovernmentProvidesHouseYouMoveToThatPlace;
  String  getAnyBenefitsOfSwasthyaSathi;
  String  willingToGoBackToNativeIfSuitableJobsMadeAvailable;
  String  lifeInSlumAreas;
  String  kindOfProblemDoYouFace;
  String  faceAnyProblemsFromIndustriesAroundYou;
  String  whetherAllChildrenEnrolledInSchool;
  String  studentGender;
  String  typeOfSchool;
  String  notGoingDropoutAge;
  String  reasonOfDropout;
  String  suggestionForImprovement;

  factory SlumsApi.fromJson(Map<String, dynamic> json) => SlumsApi(
        userId: json["user_id"],
        thisPlaceIsAllottedToYouByAnyAuthority:
            json["this_place_is_allotted_to_you_by_any_authority"],
        statusOfLand: json["status_of_land"],
        isTherePatta: json["is_there_patta"],
        howLongHaveYouStayedHere: json["how_long_have_you_stayed_here"],
        typesOfWorkYouAreEngaged: json["types_of_work_you_are_engaged"],
        areYouSkilledLabour: json["are_you_skilled_labour"],
        skillType: json["skill_type"],
        dueToCovid19YourIncomeJobBeenAffected:
            json["due_to_covid19_your_income_job_been_affected"],
        getAnyRationAssistanceFromGovernment:
            json["get_any_ration_assistance_from_government"],
        typeOfRationCardYouAvail: json["type_of_ration_card_you_avail"],
        getAnyFinancialAssitanceFromGovernment:
            json["get_any_financial_assitance_from_government"],
        getAnyBenefitsFromAnyStateCentralHousingSchemes:
            json["get_any_benefits_from_any_state_central_housing_schemes"],
        allottedAnyHouseUnderTheSlumRehabilitationProject:
            json["allotted_any_house_under_the_slum_rehabilitation_project"],
        ifGovernmentProvidesHouseYouMoveToThatPlace:
            json["if_government_provides_house_you_move_to_that_place"],
        getAnyBenefitsOfSwasthyaSathi:
            json["get_any_benefits_of_swasthya_sathi"],
        willingToGoBackToNativeIfSuitableJobsMadeAvailable: json[
            "willing_to_go_back_to_native_if_suitable_jobs_made_available"],
        lifeInSlumAreas: json["life_in_slum_areas"],
        kindOfProblemDoYouFace: json["kind_of_problem_do_you_face"],
        faceAnyProblemsFromIndustriesAroundYou:
            json["face_any_problems_from_industries_around_you"],
        whetherAllChildrenEnrolledInSchool:
            json["whether_all_children_enrolled_in_school"],
        studentGender: json["student_gender"],
        typeOfSchool: json["type_of_school"],
        notGoingDropoutAge: json["not_going_dropout_age"],
        reasonOfDropout: json["reason_of_dropout"],
        suggestionForImprovement: json["suggestion_for_improvement"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "this_place_is_allotted_to_you_by_any_authority":
            thisPlaceIsAllottedToYouByAnyAuthority,
        "status_of_land": statusOfLand,
        "is_there_patta": isTherePatta,
        "how_long_have_you_stayed_here": howLongHaveYouStayedHere,
        "types_of_work_you_are_engaged": typesOfWorkYouAreEngaged,
        "are_you_skilled_labour": areYouSkilledLabour,
        "skill_type": skillType,
        "due_to_covid19_your_income_job_been_affected":
            dueToCovid19YourIncomeJobBeenAffected,
        "get_any_ration_assistance_from_government":
            getAnyRationAssistanceFromGovernment,
        "type_of_ration_card_you_avail": typeOfRationCardYouAvail,
        "get_any_financial_assitance_from_government":
            getAnyFinancialAssitanceFromGovernment,
        "get_any_benefits_from_any_state_central_housing_schemes":
            getAnyBenefitsFromAnyStateCentralHousingSchemes,
        "allotted_any_house_under_the_slum_rehabilitation_project":
            allottedAnyHouseUnderTheSlumRehabilitationProject,
        "if_government_provides_house_you_move_to_that_place":
            ifGovernmentProvidesHouseYouMoveToThatPlace,
        "get_any_benefits_of_swasthya_sathi": getAnyBenefitsOfSwasthyaSathi,
        "willing_to_go_back_to_native_if_suitable_jobs_made_available":
            willingToGoBackToNativeIfSuitableJobsMadeAvailable,
        "life_in_slum_areas": lifeInSlumAreas,
        "kind_of_problem_do_you_face": kindOfProblemDoYouFace,
        "face_any_problems_from_industries_around_you":
            faceAnyProblemsFromIndustriesAroundYou,
        "whether_all_children_enrolled_in_school":
            whetherAllChildrenEnrolledInSchool,
        "student_gender": studentGender,
        "type_of_school": typeOfSchool,
        "not_going_dropout_age": notGoingDropoutAge,
        "reason_of_dropout": reasonOfDropout,
        "suggestion_for_improvement": suggestionForImprovement,
      };
}
