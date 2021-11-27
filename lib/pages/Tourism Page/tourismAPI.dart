// To parse this JSON data, do
//
//     final tourismApi = tourismApiFromJson(jsonString);

import 'dart:convert';

TourismApi tourismApiFromJson(String str) =>
    TourismApi.fromJson(json.decode(str));

String tourismApiToJson(TourismApi data) => json.encode(data.toJson());

class TourismApi {
  TourismApi({
    this.userId,
    this.touristsComeToThisRegionRegularly,
    this.bestSeasonForTouristToVisitThenWhy,
    this.areYouInvolvedInTouristRelatedActivities,
    this.whichTypeOfActivitiesYouInvolvedIn,
    this.workEngagementApartFromTouristActivity,
    this.noOfFamilyMembersEngageInSuchActivity,
    this.ifHandicraftWhatItemDoYouSell,
    this.whomDoYouSellYourProductsToMostOften,
    this.participateInAnyMelaForProductShowcaseSell,
    this.whereThenHowOftenDoYouVisitMela,
    this.availabolityOfTrainingCenterExhibitionCenter,
    this.sellOfProductBeforeCovid19,
    this.sellOfProductAfterCovid19,
    this.tourismSectorHelpsEconomicGrowthOfThisRegion,
    this.anySuggestionForImprovement,
    this.anyFurtherSuggestionForImprovement,
  });

  String  userId;
  String  touristsComeToThisRegionRegularly;
  String  bestSeasonForTouristToVisitThenWhy;
  String  areYouInvolvedInTouristRelatedActivities;
  String  whichTypeOfActivitiesYouInvolvedIn;
  String  workEngagementApartFromTouristActivity;
  String  noOfFamilyMembersEngageInSuchActivity;
  String  ifHandicraftWhatItemDoYouSell;
  String  whomDoYouSellYourProductsToMostOften;
  String  participateInAnyMelaForProductShowcaseSell;
  String  whereThenHowOftenDoYouVisitMela;
  String  availabolityOfTrainingCenterExhibitionCenter;
  String  sellOfProductBeforeCovid19;
  String  sellOfProductAfterCovid19;
  String  tourismSectorHelpsEconomicGrowthOfThisRegion;
  String  anySuggestionForImprovement;
  String  anyFurtherSuggestionForImprovement;

  factory TourismApi.fromJson(Map<String, dynamic> json) => TourismApi(
        userId: json["user_id"],
        touristsComeToThisRegionRegularly:
            json["tourists_come_to_this_region_regularly"],
        bestSeasonForTouristToVisitThenWhy:
            json["best_season_for_tourist_to_visit_then_why"],
        areYouInvolvedInTouristRelatedActivities:
            json["are_you_involved_in_tourist_related_activities"],
        whichTypeOfActivitiesYouInvolvedIn:
            json["which_type_of_activities_you_involved_in"],
        workEngagementApartFromTouristActivity:
            json["work_engagement_apart_from_tourist_activity"],
        noOfFamilyMembersEngageInSuchActivity:
            json["no_of_family_members_engage_in_such_activity"],
        ifHandicraftWhatItemDoYouSell:
            json["if_handicraft_what_item_do_you_sell"],
        whomDoYouSellYourProductsToMostOften:
            json["whom_do_you_sell_your_products_to_most_often"],
        participateInAnyMelaForProductShowcaseSell:
            json["participate_in_any_mela_for_product_showcase_sell"],
        whereThenHowOftenDoYouVisitMela:
            json["where_then_how_often_do_you_visit_mela"],
        availabolityOfTrainingCenterExhibitionCenter:
            json["availabolity_of_training_center_exhibition_center"],
        sellOfProductBeforeCovid19: json["sell_of_product_before_covid19"],
        sellOfProductAfterCovid19: json["sell_of_product_after_covid19"],
        tourismSectorHelpsEconomicGrowthOfThisRegion:
            json["tourism_sector_helps_economic_growth_of_this_region"],
        anySuggestionForImprovement: json["any_suggestion_for_improvement"],
        anyFurtherSuggestionForImprovement:
            json["any_further_suggestion_for_improvement"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "tourists_come_to_this_region_regularly":
            touristsComeToThisRegionRegularly,
        "best_season_for_tourist_to_visit_then_why":
            bestSeasonForTouristToVisitThenWhy,
        "are_you_involved_in_tourist_related_activities":
            areYouInvolvedInTouristRelatedActivities,
        "which_type_of_activities_you_involved_in":
            whichTypeOfActivitiesYouInvolvedIn,
        "work_engagement_apart_from_tourist_activity":
            workEngagementApartFromTouristActivity,
        "no_of_family_members_engage_in_such_activity":
            noOfFamilyMembersEngageInSuchActivity,
        "if_handicraft_what_item_do_you_sell": ifHandicraftWhatItemDoYouSell,
        "whom_do_you_sell_your_products_to_most_often":
            whomDoYouSellYourProductsToMostOften,
        "participate_in_any_mela_for_product_showcase_sell":
            participateInAnyMelaForProductShowcaseSell,
        "where_then_how_often_do_you_visit_mela":
            whereThenHowOftenDoYouVisitMela,
        "availabolity_of_training_center_exhibition_center":
            availabolityOfTrainingCenterExhibitionCenter,
        "sell_of_product_before_covid19": sellOfProductBeforeCovid19,
        "sell_of_product_after_covid19": sellOfProductAfterCovid19,
        "tourism_sector_helps_economic_growth_of_this_region":
            tourismSectorHelpsEconomicGrowthOfThisRegion,
        "any_suggestion_for_improvement": anySuggestionForImprovement,
        "any_further_suggestion_for_improvement":
            anyFurtherSuggestionForImprovement,
      };
}
