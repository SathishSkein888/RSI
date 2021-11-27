// To parse this JSON data, do
//
//     final culturalApi = culturalApiFromJson(jsonString);

import 'dart:convert';

CulturalApi culturalApiFromJson(String str) =>
    CulturalApi.fromJson(json.decode(str));

String culturalApiToJson(CulturalApi data) => json.encode(data.toJson());

class CulturalApi {
  CulturalApi({
    this.userId,
    this.popularFestivalOccasion,
    this.ifOtherSpecify,
    this.placeHaveAnySignificantHeritageSiteStructurePrecinit,
    this.visitorsDuringFestivalOccasion,
    this.problemDuringFestivalOccasion,
    this.ifSpecifyOthers,
    this.festivalHeritagePresenceHelpYouInEconomicGeneration,
    this.ifYesSpecify,
    this.touristsVisitThisPlaceRegularlyDuringFestivals,
    this.anyFurtherSuggestionIssuesForImprovement,
  });

  String userId;
  String popularFestivalOccasion;
  String ifOtherSpecify;
  String placeHaveAnySignificantHeritageSiteStructurePrecinit;
  String visitorsDuringFestivalOccasion;
  String problemDuringFestivalOccasion;
  String ifSpecifyOthers;
  String festivalHeritagePresenceHelpYouInEconomicGeneration;
  String ifYesSpecify;
  String touristsVisitThisPlaceRegularlyDuringFestivals;
  String anyFurtherSuggestionIssuesForImprovement;

  factory CulturalApi.fromJson(Map<String, dynamic> json) => CulturalApi(
        userId: json["user_id"],
        popularFestivalOccasion: json["popular_festival_occasion"],
        ifOtherSpecify: json["if_other_specify"],
        placeHaveAnySignificantHeritageSiteStructurePrecinit:
            json["place_have_any_significant_heritage_site_structure_precinit"],
        visitorsDuringFestivalOccasion:
            json["visitors_during_festival_occasion"],
        problemDuringFestivalOccasion: json["problem_during_festival_occasion"],
        ifSpecifyOthers: json["if_specify_others"],
        festivalHeritagePresenceHelpYouInEconomicGeneration:
            json["festival_heritage_presence_help_you_in_economic_generation"],
        ifYesSpecify: json["if_yes_specify"],
        touristsVisitThisPlaceRegularlyDuringFestivals:
            json["tourists_visit_this_place_regularly_during_festivals"],
        anyFurtherSuggestionIssuesForImprovement:
            json["any_further_suggestion_issues_for_improvement"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "popular_festival_occasion": popularFestivalOccasion,
        "if_other_specify": ifOtherSpecify,
        "place_have_any_significant_heritage_site_structure_precinit":
            placeHaveAnySignificantHeritageSiteStructurePrecinit,
        "visitors_during_festival_occasion": visitorsDuringFestivalOccasion,
        "problem_during_festival_occasion": problemDuringFestivalOccasion,
        "if_specify_others": ifSpecifyOthers,
        "festival_heritage_presence_help_you_in_economic_generation":
            festivalHeritagePresenceHelpYouInEconomicGeneration,
        "if_yes_specify": ifYesSpecify,
        "tourists_visit_this_place_regularly_during_festivals":
            touristsVisitThisPlaceRegularlyDuringFestivals,
        "any_further_suggestion_issues_for_improvement":
            anyFurtherSuggestionIssuesForImprovement,
      };
}
