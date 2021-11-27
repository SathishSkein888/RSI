// To parse this JSON data, do
//
//     final householdProfileApiModel = householdProfileApiModelFromJson(jsonString);

import 'dart:convert';

HouseholdProfileApiModel householdProfileApiModelFromJson(String str) =>
    HouseholdProfileApiModel.fromJson(json.decode(str));

String householdProfileApiModelToJson(HouseholdProfileApiModel data) =>
    json.encode(data.toJson());

class HouseholdProfileApiModel {
  HouseholdProfileApiModel({
    this.userId,
    this.migrated,
    this.noOfYearsMigrated,
    this.placeOfOrigin,
    this.migrationType,
    this.reasonOfMigration,
    this.otherReasonsForMigration,
    this.willingToMigrateToAnotherPlace,
    this.anotherMigratePlace,
    this.reasonForNotGoingBackToNative,
    this.otherReasonForNotGoingBackToNative,
    this.afterCovidWillingToGoBackToNative,
  });

  String  userId;
  String  migrated;
  String  noOfYearsMigrated;
  String  placeOfOrigin;
  String  migrationType;
  String  reasonOfMigration;
  String  otherReasonsForMigration;
  String  willingToMigrateToAnotherPlace;
  String  anotherMigratePlace;
  String  reasonForNotGoingBackToNative;
  String  otherReasonForNotGoingBackToNative;
  String  afterCovidWillingToGoBackToNative;

  factory HouseholdProfileApiModel.fromJson(Map<String, dynamic> json) =>
      HouseholdProfileApiModel(
        userId: json["user_id"],
        migrated: json["migrated"],
        noOfYearsMigrated: json["no_of_years_migrated"],
        placeOfOrigin: json["place_of_origin"],
        migrationType: json["migration_type"],
        reasonOfMigration: json["reason_of_migration"],
        otherReasonsForMigration: json["other_reasons_for_migration"],
        willingToMigrateToAnotherPlace:
            json["willing_to_migrate_to_another_place"],
        anotherMigratePlace: json["another_migrate_place"],
        reasonForNotGoingBackToNative:
            json["reason_for_not_going_back_to_native"],
        otherReasonForNotGoingBackToNative:
            json["other_reason_for_not_going_back_to_native"],
        afterCovidWillingToGoBackToNative:
            json["after_covid_willing_to_go_back_to_native"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "migrated": migrated,
        "no_of_years_migrated": noOfYearsMigrated,
        "place_of_origin": placeOfOrigin,
        "migration_type": migrationType,
        "reason_of_migration": reasonOfMigration,
        "other_reasons_for_migration": otherReasonsForMigration,
        "willing_to_migrate_to_another_place": willingToMigrateToAnotherPlace,
        "another_migrate_place": anotherMigratePlace,
        "reason_for_not_going_back_to_native": reasonForNotGoingBackToNative,
        "other_reason_for_not_going_back_to_native":
            otherReasonForNotGoingBackToNative,
        "after_covid_willing_to_go_back_to_native":
            afterCovidWillingToGoBackToNative,
      };
}
