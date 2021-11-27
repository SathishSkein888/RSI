// To parse this JSON data, do
//
//     final transportationApi = transportationApiFromJson(jsonString);

import 'dart:convert';

TransportationApi transportationApiFromJson(String str) =>
    TransportationApi.fromJson(json.decode(str));

String transportationApiToJson(TransportationApi data) =>
    json.encode(data.toJson());

class TransportationApi {
  TransportationApi({
    this.userId,
    this.transportationConveyanceFacilitiesSatisfactory,
    this.beforeCovid19MostPreferredModeOfTransport,
    this.afterCovid19MostPreferredModeOfTransport,
    this.selfOwnedVehicles,
    this.modeOfTransportationForSchoolCollege,
    this.modeOfTransportationForMarketShoppingcenter,
    this.modeOfTransportationForHospitalHealthcare,
    this.modeOfTransportationForParksCinemaMall,
    this.modeOfTransportationForRailwaystationBus,
    this.modeOfTransportationForTerminal,
    this.modeOfTransportationForAirport,
    this.modeOfTransportationForBankPostoffice,
    this.howOftenDoYouTravelOutstation,
    this.oustationLocation,
    this.preferredModeOfTransportation,
    this.areThereAnySignagesProvided,
    this.isThereAnyFootpathProvided,
    this.isZebraCrossingProvidedNearJunctions,
    this.availabilityOfCycleTrackPedestrainPathway,
    this.isThePathShadedWithTrees,
    this.anyFurtherSuggestionForImprovement,
  });

  String  userId;
  String  transportationConveyanceFacilitiesSatisfactory;
  String  beforeCovid19MostPreferredModeOfTransport;
  String  afterCovid19MostPreferredModeOfTransport;
  String  selfOwnedVehicles;
  String  modeOfTransportationForSchoolCollege;
  String  modeOfTransportationForMarketShoppingcenter;
  String  modeOfTransportationForHospitalHealthcare;
  String  modeOfTransportationForParksCinemaMall;
  String  modeOfTransportationForRailwaystationBus;
  String  modeOfTransportationForTerminal;
  String  modeOfTransportationForAirport;
  String  modeOfTransportationForBankPostoffice;
  String  howOftenDoYouTravelOutstation;
  String  oustationLocation;
  String  preferredModeOfTransportation;
  String areThereAnySignagesProvided;
  String  isThereAnyFootpathProvided;
  String  isZebraCrossingProvidedNearJunctions;
  String  availabilityOfCycleTrackPedestrainPathway;
  String  isThePathShadedWithTrees;
  String  anyFurtherSuggestionForImprovement;

  factory TransportationApi.fromJson(Map<String, dynamic> json) =>
      TransportationApi(
        userId: json["user_id"],
        transportationConveyanceFacilitiesSatisfactory:
            json["transportation_conveyance_facilities_satisfactory"],
        beforeCovid19MostPreferredModeOfTransport:
            json["before_covid19_most_preferred_mode_of_transport"],
        afterCovid19MostPreferredModeOfTransport:
            json["after_covid19_most_preferred_mode_of_transport"],
        selfOwnedVehicles: json["self_owned_vehicles"],
        modeOfTransportationForSchoolCollege:
            json["mode_of_transportation_for_school_college"],
        modeOfTransportationForMarketShoppingcenter:
            json["mode_of_transportation_for_market_shoppingcenter"],
        modeOfTransportationForHospitalHealthcare:
            json["mode_of_transportation_for_hospital_healthcare"],
        modeOfTransportationForParksCinemaMall:
            json["mode_of_transportation_for_parks_cinema_mall"],
        modeOfTransportationForRailwaystationBus:
            json["mode_of_transportation_for_railwaystation_bus"],
        modeOfTransportationForTerminal:
            json["mode_of_transportation_for_terminal"],
        modeOfTransportationForAirport:
            json["mode_of_transportation_for_airport"],
        modeOfTransportationForBankPostoffice:
            json["mode_of_transportation_for_bank_postoffice"],
        howOftenDoYouTravelOutstation:
            json["how_often_do_you_travel_outstation"],
        oustationLocation: json["oustation_location"],
        preferredModeOfTransportation: json["preferred_mode_of_transportation"],
        areThereAnySignagesProvided: json["are_there_any_signages_provided"],
        isThereAnyFootpathProvided: json["is_there_any_footpath_provided"],
        isZebraCrossingProvidedNearJunctions:
            json["is_zebra_crossing_provided_near_junctions"],
        availabilityOfCycleTrackPedestrainPathway:
            json["availability_of_cycle_track_pedestrain_pathway"],
        isThePathShadedWithTrees: json["is_the_path_shaded_with_trees"],
        anyFurtherSuggestionForImprovement:
            json["any_further_suggestion_for_improvement"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "transportation_conveyance_facilities_satisfactory":
            transportationConveyanceFacilitiesSatisfactory,
        "before_covid19_most_preferred_mode_of_transport":
            beforeCovid19MostPreferredModeOfTransport,
        "after_covid19_most_preferred_mode_of_transport":
            afterCovid19MostPreferredModeOfTransport,
        "self_owned_vehicles": selfOwnedVehicles,
        "mode_of_transportation_for_school_college":
            modeOfTransportationForSchoolCollege,
        "mode_of_transportation_for_market_shoppingcenter":
            modeOfTransportationForMarketShoppingcenter,
        "mode_of_transportation_for_hospital_healthcare":
            modeOfTransportationForHospitalHealthcare,
        "mode_of_transportation_for_parks_cinema_mall":
            modeOfTransportationForParksCinemaMall,
        "mode_of_transportation_for_railwaystation_bus":
            modeOfTransportationForRailwaystationBus,
        "mode_of_transportation_for_terminal": modeOfTransportationForTerminal,
        "mode_of_transportation_for_airport": modeOfTransportationForAirport,
        "mode_of_transportation_for_bank_postoffice":
            modeOfTransportationForBankPostoffice,
        "how_often_do_you_travel_outstation": howOftenDoYouTravelOutstation,
        "oustation_location": oustationLocation,
        "preferred_mode_of_transportation": preferredModeOfTransportation,
        "are_there_any_signages_provided": areThereAnySignagesProvided,
        "is_there_any_footpath_provided": isThereAnyFootpathProvided,
        "is_zebra_crossing_provided_near_junctions":
            isZebraCrossingProvidedNearJunctions,
        "availability_of_cycle_track_pedestrain_pathway":
            availabilityOfCycleTrackPedestrainPathway,
        "is_the_path_shaded_with_trees": isThePathShadedWithTrees,
        "any_further_suggestion_for_improvement":
            anyFurtherSuggestionForImprovement,
      };
}
