// To parse this JSON data, do
//
//     final housingApi = housingApiFromJson(jsonString);

import 'dart:convert';

HousingApi housingApiFromJson(String str) =>
    HousingApi.fromJson(json.decode(str));

String housingApiToJson(HousingApi data) => json.encode(data.toJson());

class HousingApi {
  HousingApi({
    this.userId,
    this.houseType,
    this.noOfFloors,
    this.wallMaterialUsed,
    this.roofMaterialUsed,
    this.houseAge,
    this.houseCondition,
    this.ownershipType,
    this.rentAmount,
    this.landOwnership,
    this.approxPriceRangeOfLandPerKatha,
    this.otherLandProperty,
    this.whereIsTheLand,
    this.areYouWillingToBuy,
    this.usageOfResidentialBuilding,
    this.assetsOwnedByHousehold,
    this.cookingFuel,
  });

  String  userId;
  String  houseType;
  String  noOfFloors;
  String  wallMaterialUsed;
  String  roofMaterialUsed;
  String  houseAge;
  String  houseCondition;
  String  ownershipType;
  String  rentAmount;
  String  landOwnership;
  String  approxPriceRangeOfLandPerKatha;
  String  otherLandProperty;
  String  whereIsTheLand;
  String  areYouWillingToBuy;
  String  usageOfResidentialBuilding;
  String  assetsOwnedByHousehold;
  String  cookingFuel;

  factory HousingApi.fromJson(Map<String, dynamic> json) => HousingApi(
        userId: json["user_id"],
        houseType: json["house_type"],
        noOfFloors: json["no_of_floors"],
        wallMaterialUsed: json["wall_material_used"],
        roofMaterialUsed: json["roof_material_used"],
        houseAge: json["house_age"],
        houseCondition: json["house_condition"],
        ownershipType: json["ownership_type"],
        rentAmount: json["rent_amount"],
        landOwnership: json["land_ownership"],
        approxPriceRangeOfLandPerKatha:
            json["approx_price_range_of_land_per_katha"],
        otherLandProperty: json["other_land_property"],
        whereIsTheLand: json["where_is_the_land"],
        areYouWillingToBuy: json["are_you_willing_to_buy"],
        usageOfResidentialBuilding: json["usage_of_residential_building"],
        assetsOwnedByHousehold: json["assets_owned_by_household"],
        cookingFuel: json["cooking_fuel"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "house_type": houseType,
        "no_of_floors": noOfFloors,
        "wall_material_used": wallMaterialUsed,
        "roof_material_used": roofMaterialUsed,
        "house_age": houseAge,
        "house_condition": houseCondition,
        "ownership_type": ownershipType,
        "rent_amount": rentAmount,
        "land_ownership": landOwnership,
        "approx_price_range_of_land_per_katha": approxPriceRangeOfLandPerKatha,
        "other_land_property": otherLandProperty,
        "where_is_the_land": whereIsTheLand,
        "are_you_willing_to_buy": areYouWillingToBuy,
        "usage_of_residential_building": usageOfResidentialBuilding,
        "assets_owned_by_household": assetsOwnedByHousehold,
        "cooking_fuel": cookingFuel,
      };
}
