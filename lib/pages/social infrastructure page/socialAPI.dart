// To parse this JSON data, do
//
//     final socialApi = socialApiFromJson(jsonString);

import 'dart:convert';

SocialApi socialApiFromJson(String str) => SocialApi.fromJson(json.decode(str));

String socialApiToJson(SocialApi data) => json.encode(data.toJson());

class SocialApi {
  SocialApi({
    this.userId,
    this.typeOfSchoolInfrastructureDoYouPrefer,
    this.typeOfEducationAvailabilityDistance,
    this.mostPreferredMode,
    this.yourRegionHasGoodOpportunitiesInEducationFacilities,
    this.suggestionForEducationalImprovement,
    this.mostPreferredHealthFacility,
    this.healthDistance,
    this.yourRegionHasGoodOpportunitiesInHealthFacilities,
    this.suggestionForHealthFacilitiesImprovement,
    this.availablilityOfParksPlaygroundOtherRecreationSpaces,
    this.yourFamilyMembersGoToParkPlayground,
    this.howRegular,
    this.suggestionForRecreationSpaceImprovement,
    this.grantFromAnyStateGovernmentFlagshipScheme,
    this.otherSchemes,
  });

  String  userId;
  String  typeOfSchoolInfrastructureDoYouPrefer;
  String  typeOfEducationAvailabilityDistance;
  String  mostPreferredMode;
  String  yourRegionHasGoodOpportunitiesInEducationFacilities;
  String  suggestionForEducationalImprovement;
  String  mostPreferredHealthFacility;
  String  healthDistance;
  String  yourRegionHasGoodOpportunitiesInHealthFacilities;
  String  suggestionForHealthFacilitiesImprovement;
  String  availablilityOfParksPlaygroundOtherRecreationSpaces;
  String  yourFamilyMembersGoToParkPlayground;
  String  howRegular;
  String  suggestionForRecreationSpaceImprovement;
  String  grantFromAnyStateGovernmentFlagshipScheme;
  String  otherSchemes;

  factory SocialApi.fromJson(Map<String, dynamic> json) => SocialApi(
        userId: json["user_id"],
        typeOfSchoolInfrastructureDoYouPrefer:
            json["type_of_school_infrastructure_do_you_prefer"],
        typeOfEducationAvailabilityDistance:
            json["type_of_education_availability_distance"],
        mostPreferredMode: json["most_preferred_mode"],
        yourRegionHasGoodOpportunitiesInEducationFacilities:
            json["your_region_has_good_opportunities_in_education_facilities"],
        suggestionForEducationalImprovement:
            json["suggestion_for_educational_improvement"],
        mostPreferredHealthFacility: json["most_preferred_health_facility"],
        healthDistance: json["health_distance"],
        yourRegionHasGoodOpportunitiesInHealthFacilities:
            json["your_region_has_good_opportunities_in_health_facilities"],
        suggestionForHealthFacilitiesImprovement:
            json["suggestion_for_health_facilities_improvement"],
        availablilityOfParksPlaygroundOtherRecreationSpaces:
            json["availablility_of_parks_playground_other_recreation_spaces"],
        yourFamilyMembersGoToParkPlayground:
            json["your_family_members_go_to_park_playground"],
        howRegular: json["how_regular"],
        suggestionForRecreationSpaceImprovement:
            json["suggestion_for_recreation_space_improvement"],
        grantFromAnyStateGovernmentFlagshipScheme:
            json["grant_from_any_state_government_flagship_scheme"],
        otherSchemes: json["other_schemes"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "type_of_school_infrastructure_do_you_prefer":
            typeOfSchoolInfrastructureDoYouPrefer,
        "type_of_education_availability_distance":
            typeOfEducationAvailabilityDistance,
        "most_preferred_mode": mostPreferredMode,
        "your_region_has_good_opportunities_in_education_facilities":
            yourRegionHasGoodOpportunitiesInEducationFacilities,
        "suggestion_for_educational_improvement":
            suggestionForEducationalImprovement,
        "most_preferred_health_facility": mostPreferredHealthFacility,
        "health_distance": healthDistance,
        "your_region_has_good_opportunities_in_health_facilities":
            yourRegionHasGoodOpportunitiesInHealthFacilities,
        "suggestion_for_health_facilities_improvement":
            suggestionForHealthFacilitiesImprovement,
        "availablility_of_parks_playground_other_recreation_spaces":
            availablilityOfParksPlaygroundOtherRecreationSpaces,
        "your_family_members_go_to_park_playground":
            yourFamilyMembersGoToParkPlayground,
        "how_regular": howRegular,
        "suggestion_for_recreation_space_improvement":
            suggestionForRecreationSpaceImprovement,
        "grant_from_any_state_government_flagship_scheme":
            grantFromAnyStateGovernmentFlagshipScheme,
        "other_schemes": otherSchemes,
      };
}
