// To parse this JSON data, do
//
//     final physicalApi = physicalApiFromJson(jsonString);

import 'dart:convert';

PhysicalApi physicalApiFromJson(String str) =>
    PhysicalApi.fromJson(json.decode(str));

String physicalApiToJson(PhysicalApi data) => json.encode(data.toJson());

class PhysicalApi {
  PhysicalApi({
    this.userId,
    this.sourceOfDrinkingWater,
    this.isConnectionAvailableWithinPremises,
    this.frequencyOfMunicipalSupply,
    this.durationOfSupply,
    this.qualityOfWater,
    this.satisfiedWithTheDrinkingWaterSupply,
    this.typesOfComplaints,
    this.complaintsRedressesTime,
    this.sourceOfElectricity,
    this.electricityConnection,
    this.powerCutDuration,
    this.availabilityOfStreetLight,
    this.conditionOfStreetLight,
    this.typeOfStreetLight,
    this.availabilityOfDrainageLine,
    this.householdWasteWaterOutlet,
    this.whereIsRainWaterCollected,
    this.whereIsHouseholdSolidWasteDisposedOff,
    this.doorToDoorCollection,
    this.isSolidWasteSegregationAtHouseholdLevel,
  });

  String  userId;
  String  sourceOfDrinkingWater;
  String  isConnectionAvailableWithinPremises;
  String  frequencyOfMunicipalSupply;
  String  durationOfSupply;
  String  qualityOfWater;
  String  satisfiedWithTheDrinkingWaterSupply;
  String  typesOfComplaints;
  String  complaintsRedressesTime;
  String  sourceOfElectricity;
  String  electricityConnection;
  String  powerCutDuration;
  String  availabilityOfStreetLight;
  String  conditionOfStreetLight;
  String  typeOfStreetLight;
  String  availabilityOfDrainageLine;
  String  householdWasteWaterOutlet;
  String  whereIsRainWaterCollected;
  String  whereIsHouseholdSolidWasteDisposedOff;
  String  doorToDoorCollection;
  String  isSolidWasteSegregationAtHouseholdLevel;

  factory PhysicalApi.fromJson(Map<String, dynamic> json) => PhysicalApi(
        userId: json["user_id"],
        sourceOfDrinkingWater: json["source_of_drinking_water"],
        isConnectionAvailableWithinPremises:
            json["is_connection_available_within_premises"],
        frequencyOfMunicipalSupply: json["frequency_of_municipal_supply"],
        durationOfSupply: json["duration_of_supply"],
        qualityOfWater: json["quality_of_water"],
        satisfiedWithTheDrinkingWaterSupply:
            json["satisfied_with_the_drinking_water_supply"],
        typesOfComplaints: json["types_of_complaints"],
        complaintsRedressesTime: json["complaints_redresses_time"],
        sourceOfElectricity: json["source_of_electricity"],
        electricityConnection: json["electricity_connection"],
        powerCutDuration: json["power_cut_duration"],
        availabilityOfStreetLight: json["availability_of_street_light"],
        conditionOfStreetLight: json["condition_of_street_light"],
        typeOfStreetLight: json["type_of_street_light"],
        availabilityOfDrainageLine: json["availability_of_drainage_line"],
        householdWasteWaterOutlet: json["household_waste_water_outlet"],
        whereIsRainWaterCollected: json["where_is_rain_water_collected"],
        whereIsHouseholdSolidWasteDisposedOff:
            json["where_is_household_solid_waste_disposed_off"],
        doorToDoorCollection: json["door_to_door_collection"],
        isSolidWasteSegregationAtHouseholdLevel:
            json["is_solid_waste_segregation_at_household_level"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "source_of_drinking_water": sourceOfDrinkingWater,
        "is_connection_available_within_premises":
            isConnectionAvailableWithinPremises,
        "frequency_of_municipal_supply": frequencyOfMunicipalSupply,
        "duration_of_supply": durationOfSupply,
        "quality_of_water": qualityOfWater,
        "satisfied_with_the_drinking_water_supply":
            satisfiedWithTheDrinkingWaterSupply,
        "types_of_complaints": typesOfComplaints,
        "complaints_redresses_time": complaintsRedressesTime,
        "source_of_electricity": sourceOfElectricity,
        "electricity_connection": electricityConnection,
        "power_cut_duration": powerCutDuration,
        "availability_of_street_light": availabilityOfStreetLight,
        "condition_of_street_light": conditionOfStreetLight,
        "type_of_street_light": typeOfStreetLight,
        "availability_of_drainage_line": availabilityOfDrainageLine,
        "household_waste_water_outlet": householdWasteWaterOutlet,
        "where_is_rain_water_collected": whereIsRainWaterCollected,
        "where_is_household_solid_waste_disposed_off":
            whereIsHouseholdSolidWasteDisposedOff,
        "door_to_door_collection": doorToDoorCollection,
        "is_solid_waste_segregation_at_household_level":
            isSolidWasteSegregationAtHouseholdLevel,
      };
}
