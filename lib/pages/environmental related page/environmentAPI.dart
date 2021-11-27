// To parse this JSON data, do
//
//     final environmentApi = environmentApiFromJson(jsonString);

import 'dart:convert';

EnvironmentApi environmentApiFromJson(String str) =>
    EnvironmentApi.fromJson(json.decode(str));

String environmentApiToJson(EnvironmentApi data) => json.encode(data.toJson());

class EnvironmentApi {
  EnvironmentApi({
    this.userId,
    this.familyNearbyPersonSufferFromDiseasesInLastFewYears,
    this.diseases,
    this.familyMemberFaceAnyProblemInBreathing,
    this.majorCauseOfPollution,
    this.otherCauseForPollution,
    this.faceAnyIssuesDuringRainySeason,
    this.issuesInRainySeason,
    this.whetherTheAreaIsProneToFloodingDueToRains,
    this.howManyDaysItTakesToNormalCondition,
    this.duringFloodingIsRehabilitationCenterAvailable,
    this.whetherAnyFundsGrantedToYouForSuchDisaster,
    this.doHoardingsCreateAnyVisualDisturbanceWhileDriving,
    this.doesTrafficMovementNoiseAnIssueForYourLocality,
    this.suggestionForImprovementInReductionOfTrafficNoise,
    this.whetherTheWasteDisposedOffInNearbyRiver,
    this.suggesstionForImprovementInWasteDisposedOffIssue,
  });

  String userId;
  String familyNearbyPersonSufferFromDiseasesInLastFewYears;
  String diseases;
  String familyMemberFaceAnyProblemInBreathing;
  String majorCauseOfPollution;
  String otherCauseForPollution;
  String faceAnyIssuesDuringRainySeason;
  String issuesInRainySeason;
  String whetherTheAreaIsProneToFloodingDueToRains;
  String howManyDaysItTakesToNormalCondition;
  String duringFloodingIsRehabilitationCenterAvailable;
  String whetherAnyFundsGrantedToYouForSuchDisaster;
  String doHoardingsCreateAnyVisualDisturbanceWhileDriving;
  String doesTrafficMovementNoiseAnIssueForYourLocality;
  String suggestionForImprovementInReductionOfTrafficNoise;
  String whetherTheWasteDisposedOffInNearbyRiver;
  String suggesstionForImprovementInWasteDisposedOffIssue;

  factory EnvironmentApi.fromJson(Map<String, dynamic> json) => EnvironmentApi(
        userId: json["user_id"],
        familyNearbyPersonSufferFromDiseasesInLastFewYears:
            json["family_nearby_person_suffer_from_diseases_in_last_few_years"],
        diseases: json["diseases"],
        familyMemberFaceAnyProblemInBreathing:
            json["family_member_face_any_problem_in_breathing"],
        majorCauseOfPollution: json["major_cause_of_pollution"],
        otherCauseForPollution: json["other_cause_for_pollution"],
        faceAnyIssuesDuringRainySeason:
            json["face_any_issues_during_rainy_season"],
        issuesInRainySeason: json["issues_in_rainy_season"],
        whetherTheAreaIsProneToFloodingDueToRains:
            json["whether_the_area_is_prone_to_flooding_due_to_rains"],
        howManyDaysItTakesToNormalCondition:
            json["how_many_days_it_takes_to_normal_condition"],
        duringFloodingIsRehabilitationCenterAvailable:
            json["during_flooding_is_rehabilitation_center_available"],
        whetherAnyFundsGrantedToYouForSuchDisaster:
            json["whether_any_funds_granted_to_you_for_such_disaster"],
        doHoardingsCreateAnyVisualDisturbanceWhileDriving:
            json["do_hoardings_create_any_visual_disturbance_while_driving"],
        doesTrafficMovementNoiseAnIssueForYourLocality:
            json["does_traffic_movement_noise_an_issue_for_your_locality"],
        suggestionForImprovementInReductionOfTrafficNoise:
            json["suggestion_for_improvement_in_reduction_of_traffic_noise"],
        whetherTheWasteDisposedOffInNearbyRiver:
            json["whether_the_waste_disposed_off_in_nearby_river"],
        suggesstionForImprovementInWasteDisposedOffIssue:
            json["suggesstion_for_improvement_in_waste_disposed_off_issue"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "family_nearby_person_suffer_from_diseases_in_last_few_years":
            familyNearbyPersonSufferFromDiseasesInLastFewYears,
        "diseases": diseases,
        "family_member_face_any_problem_in_breathing":
            familyMemberFaceAnyProblemInBreathing,
        "major_cause_of_pollution": majorCauseOfPollution,
        "other_cause_for_pollution": otherCauseForPollution,
        "face_any_issues_during_rainy_season": faceAnyIssuesDuringRainySeason,
        "issues_in_rainy_season": issuesInRainySeason,
        "whether_the_area_is_prone_to_flooding_due_to_rains":
            whetherTheAreaIsProneToFloodingDueToRains,
        "how_many_days_it_takes_to_normal_condition":
            howManyDaysItTakesToNormalCondition,
        "during_flooding_is_rehabilitation_center_available":
            duringFloodingIsRehabilitationCenterAvailable,
        "whether_any_funds_granted_to_you_for_such_disaster":
            whetherAnyFundsGrantedToYouForSuchDisaster,
        "do_hoardings_create_any_visual_disturbance_while_driving":
            doHoardingsCreateAnyVisualDisturbanceWhileDriving,
        "does_traffic_movement_noise_an_issue_for_your_locality":
            doesTrafficMovementNoiseAnIssueForYourLocality,
        "suggestion_for_improvement_in_reduction_of_traffic_noise":
            suggestionForImprovementInReductionOfTrafficNoise,
        "whether_the_waste_disposed_off_in_nearby_river":
            whetherTheWasteDisposedOffInNearbyRiver,
        "suggesstion_for_improvement_in_waste_disposed_off_issue":
            suggesstionForImprovementInWasteDisposedOffIssue,
      };
}
