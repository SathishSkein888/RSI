// To parse this JSON data, do
//
//     final economyApi = economyApiFromJson(jsonString);

import 'dart:convert';

EconomyApi economyApiFromJson(String str) =>
    EconomyApi.fromJson(json.decode(str));

String economyApiToJson(EconomyApi data) => json.encode(data.toJson());

class EconomyApi {
  EconomyApi({
    this.userId,
    this.employmentEngagementType,
    this.occupation,
    this.ifConstructionWork,
    this.familyMembersWorkingAsParttimeEmployees,
    this.industryType,
    this.workingIndustry,
    this.afterCovid19ImpactOnJobOpportunity,
    this.industrialSectorBeenAffectedAfterCovid19,
    this.suggestionForHowJobOpportunitiesCanBeMadeAvailable,
    this.familyMembersReceivePensionPension,
    this.monthlyExpenditure,
    this.impactOnMonthlyExpenditureAfterCovid19,
    this.visitMarketBeforeCovid19,
    this.visitMarketAfterCovid19,
    this.preferredWayOfShoppingBeforeCovid19,
    this.preferredWayOfShoppingAfterCovid19,
    this.howOftenDoYouDoOnlineShopping,
  });

  String userId;
  String employmentEngagementType;
  String occupation;
  String ifConstructionWork;
  String familyMembersWorkingAsParttimeEmployees;
  String industryType;
  String workingIndustry;
  String afterCovid19ImpactOnJobOpportunity;
  String industrialSectorBeenAffectedAfterCovid19;
  String suggestionForHowJobOpportunitiesCanBeMadeAvailable;
  String familyMembersReceivePensionPension;
  String monthlyExpenditure;
  String impactOnMonthlyExpenditureAfterCovid19;
  String visitMarketBeforeCovid19;
  String visitMarketAfterCovid19;
  String preferredWayOfShoppingBeforeCovid19;
  String preferredWayOfShoppingAfterCovid19;
  String howOftenDoYouDoOnlineShopping;

  factory EconomyApi.fromJson(Map<String, dynamic> json) => EconomyApi(
        userId: json["user_id"],
        employmentEngagementType: json["employment_engagement_type"],
        occupation: json["occupation"],
        ifConstructionWork: json["if_construction_work"],
        familyMembersWorkingAsParttimeEmployees:
            json["family_members_working_as_parttime_employees"],
        industryType: json["industry_type"],
        workingIndustry: json["working_industry"],
        afterCovid19ImpactOnJobOpportunity:
            json["after_covid19_impact_on_job_opportunity"],
        industrialSectorBeenAffectedAfterCovid19:
            json["industrial_sector_been_affected_after_covid19"],
        suggestionForHowJobOpportunitiesCanBeMadeAvailable:
            json["suggestion_for_how_job_opportunities_can_be_made_available"],
        familyMembersReceivePensionPension:
            json["family_members_receive_pension,pension"],
        monthlyExpenditure: json["monthly_expenditure"],
        impactOnMonthlyExpenditureAfterCovid19:
            json["impact_on_monthly_expenditure_after_covid19"],
        visitMarketBeforeCovid19: json["visit_market_before_covid19"],
        visitMarketAfterCovid19: json["visit_market_after_covid19"],
        preferredWayOfShoppingBeforeCovid19:
            json["preferred_way_of_shopping_before_covid19"],
        preferredWayOfShoppingAfterCovid19:
            json["preferred_way_of_shopping_after_covid19"],
        howOftenDoYouDoOnlineShopping:
            json["how_often_do_you_do_online_shopping"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "employment_engagement_type": employmentEngagementType,
        "occupation": occupation,
        "if_construction_work": ifConstructionWork,
        "family_members_working_as_parttime_employees":
            familyMembersWorkingAsParttimeEmployees,
        "industry_type": industryType,
        "working_industry": workingIndustry,
        "after_covid19_impact_on_job_opportunity":
            afterCovid19ImpactOnJobOpportunity,
        "industrial_sector_been_affected_after_covid19":
            industrialSectorBeenAffectedAfterCovid19,
        "suggestion_for_how_job_opportunities_can_be_made_available":
            suggestionForHowJobOpportunitiesCanBeMadeAvailable,
        "family_members_receive_pension,pension":
            familyMembersReceivePensionPension,
        "monthly_expenditure": monthlyExpenditure,
        "impact_on_monthly_expenditure_after_covid19":
            impactOnMonthlyExpenditureAfterCovid19,
        "visit_market_before_covid19": visitMarketBeforeCovid19,
        "visit_market_after_covid19": visitMarketAfterCovid19,
        "preferred_way_of_shopping_before_covid19":
            preferredWayOfShoppingBeforeCovid19,
        "preferred_way_of_shopping_after_covid19":
            preferredWayOfShoppingAfterCovid19,
        "how_often_do_you_do_online_shopping": howOftenDoYouDoOnlineShopping,
      };
}
