// To parse this JSON data, do
//
//     final coastalApi = coastalApiFromJson(jsonString);

import 'dart:convert';

CoastalApi coastalApiFromJson(String str) =>
    CoastalApi.fromJson(json.decode(str));

String coastalApiToJson(CoastalApi data) => json.encode(data.toJson());

class CoastalApi {
  CoastalApi({
    this.userId,
    this.doYouHaveBoats,
    this.purposeOfUsingBoatss,
    this.areYouAssociatedWithFishingRelatedActivities,
    this.roleInFishingRelatedActivities,
    this.haveYouBeenEngagedInOtherActivitiesApartFromFishing,
    this.otherActivitiesApartFromFishing,
    this.thinkLivingInACoastalRegionIsAThreatAnOpportunity,
    this.howDoYouGetTheInformationRelatedToNaturalThreats,
    this.safePlaceDuringNaturalEvents,
    this.afterDisasterHowManyDaysItTakeToComeToNormal,
    this.majorDamagesDuringNaturalCalamities,
    this.availabilityOfRationDuringTheNaturalDisaster,
    this.whetherAnyFundAreaGrantedForTheFloodProneArea,
    this.doesThisRegionHaveAnyTourismOpportunities,
    this.anyFurtherSuggestionIssues,
  });

  String userId;
  String doYouHaveBoats;
  String purposeOfUsingBoatss;
  String areYouAssociatedWithFishingRelatedActivities;
  String roleInFishingRelatedActivities;
  String haveYouBeenEngagedInOtherActivitiesApartFromFishing;
  String otherActivitiesApartFromFishing;
  String thinkLivingInACoastalRegionIsAThreatAnOpportunity;
  String howDoYouGetTheInformationRelatedToNaturalThreats;
  String safePlaceDuringNaturalEvents;
  String afterDisasterHowManyDaysItTakeToComeToNormal;
  String majorDamagesDuringNaturalCalamities;
  String availabilityOfRationDuringTheNaturalDisaster;
  String whetherAnyFundAreaGrantedForTheFloodProneArea;
  String doesThisRegionHaveAnyTourismOpportunities;
  String anyFurtherSuggestionIssues;

  factory CoastalApi.fromJson(Map<String, dynamic> json) => CoastalApi(
        userId: json["user_id"],
        doYouHaveBoats: json["do_you_have_boats"],
        purposeOfUsingBoatss: json["purpose_of_using_boatss"],
        areYouAssociatedWithFishingRelatedActivities:
            json["are_you_associated_with_fishing_related_activities"],
        roleInFishingRelatedActivities:
            json["role_in_fishing_related_activities"],
        haveYouBeenEngagedInOtherActivitiesApartFromFishing: json[
            "have_you_been_engaged_in_other_activities_apart_from_fishing"],
        otherActivitiesApartFromFishing:
            json["other_activities_apart_from_fishing"],
        thinkLivingInACoastalRegionIsAThreatAnOpportunity:
            json["think_living_in_a_coastal_region_is_a_threat_an_opportunity"],
        howDoYouGetTheInformationRelatedToNaturalThreats:
            json["how_do_you_get_the_information_related_to_natural_threats"],
        safePlaceDuringNaturalEvents: json["safe_place_during_natural_events"],
        afterDisasterHowManyDaysItTakeToComeToNormal:
            json["after_disaster_how_many_days_it_take_to_come_to_normal"],
        majorDamagesDuringNaturalCalamities:
            json["major_damages_during_natural_calamities"],
        availabilityOfRationDuringTheNaturalDisaster:
            json["availability_of_ration_during_the_natural_disaster"],
        whetherAnyFundAreaGrantedForTheFloodProneArea:
            json["whether_any_fund_area_granted_for_the_flood_prone_area"],
        doesThisRegionHaveAnyTourismOpportunities:
            json["does_this_region_have_any_tourism_opportunities"],
        anyFurtherSuggestionIssues: json["any_further_suggestion_issues"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "do_you_have_boats": doYouHaveBoats,
        "purpose_of_using_boatss": purposeOfUsingBoatss,
        "are_you_associated_with_fishing_related_activities":
            areYouAssociatedWithFishingRelatedActivities,
        "role_in_fishing_related_activities": roleInFishingRelatedActivities,
        "have_you_been_engaged_in_other_activities_apart_from_fishing":
            haveYouBeenEngagedInOtherActivitiesApartFromFishing,
        "other_activities_apart_from_fishing": otherActivitiesApartFromFishing,
        "think_living_in_a_coastal_region_is_a_threat_an_opportunity":
            thinkLivingInACoastalRegionIsAThreatAnOpportunity,
        "how_do_you_get_the_information_related_to_natural_threats":
            howDoYouGetTheInformationRelatedToNaturalThreats,
        "safe_place_during_natural_events": safePlaceDuringNaturalEvents,
        "after_disaster_how_many_days_it_take_to_come_to_normal":
            afterDisasterHowManyDaysItTakeToComeToNormal,
        "major_damages_during_natural_calamities":
            majorDamagesDuringNaturalCalamities,
        "availability_of_ration_during_the_natural_disaster":
            availabilityOfRationDuringTheNaturalDisaster,
        "whether_any_fund_area_granted_for_the_flood_prone_area":
            whetherAnyFundAreaGrantedForTheFloodProneArea,
        "does_this_region_have_any_tourism_opportunities":
            doesThisRegionHaveAnyTourismOpportunities,
        "any_further_suggestion_issues": anyFurtherSuggestionIssues,
      };
}
