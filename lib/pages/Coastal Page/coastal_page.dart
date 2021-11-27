import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/coastal_data.dart';
import 'package:socio_survey/models/CoastalQuestion.dart';
import 'package:socio_survey/pages/environmental%20related%20page/environmental_related_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;

class CoastalPage extends StatefulWidget {
  CoastalPage({Key key}) : super(key: key);

  @override
  _CoastalPageState createState() => _CoastalPageState();
}

class _CoastalPageState extends State<CoastalPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Coastal coastal;
  @override
  void initState() {
    var json = costalData;
    coastal = Coastal.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(coastal?.toJson());
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/coastal_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      coastal.question[i].ans = val;
    });
  }

  getAns() {
    print(coastal.question);
    coastal.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Coastal';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${coastal.title}',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < coastal.question.length; i++)
                  if (i == 0 ||
                      i == 2 ||
                      i == 4 ||
                      i == 6 ||
                      i == 7 ||
                      i == 8 ||
                      i == 9 ||
                      i == 10 ||
                      i == 11 ||
                      i == 12 ||
                      i == 13 ||
                      i == 14 ||
                      i == 1 && coastal.question[0].ans == "Yes" ||
                      i == 3 && coastal.question[2].ans == "Yes" ||
                      i == 5 && coastal.question[4].ans == "Yes")
                    Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0)),

                        // alignment: Alignment.centerLeft,
                        child: Column(children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                coastal.question[i].qus.toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                ),
                              )),
                          if (coastal.question[i].type == Type.RADIO)
                            for (var j = 0;
                                j < coastal.question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.deepOrange,
                                    value: coastal.question[i].choice[j]
                                        .toString(),
                                    groupValue: coastal.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(coastal.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  coastal.question[i].choice[j].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                          if (coastal.question[i].type == Type.TEXT)
                            TextField(
                              onChanged: (val) {
                                coastal.question[i].ans = val;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter here'),
                            ),
                          if (coastal.question[i].type == Type.RADIOWITHTEXT)
                            for (var j = 0;
                                j < coastal.question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.deepOrange,
                                    value: coastal.question[i].choice[j]
                                        .toString(),
                                    groupValue: coastal.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(coastal.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  coastal.question[i].choice[j].toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: coastal.question[i].choice.length -
                                            1 ==
                                        j
                                    ? TextField(
                                        onChanged: (val) {
                                          coastal.question[i].ans = val;
                                          print(coastal.question[i].toJson());
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter here'),
                                      )
                                    : SizedBox(),
                              ),
                        ])),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    color: Color(0xfff89d4cf),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      var ansStatus = false;
                      for (var x = 0; x < coastal.question.length; x++) {
                        if (coastal.question[0].ans.length > 0 &&
                            //coastal.question[1].ans.length > 0 &&
                            coastal.question[2].ans.length > 0 &&
                            //coastal.question[3].ans.length > 0 &&
                            coastal.question[4].ans.length > 0 &&
                            // coastal.question[5].ans.length > 0 &&
                            coastal.question[6].ans.length > 0 &&
                            coastal.question[7].ans.length > 0 &&
                            coastal.question[8].ans.length > 0 &&
                            coastal.question[9].ans.length > 0 &&
                            coastal.question[10].ans.length > 0 &&
                            coastal.question[11].ans.length > 0 &&
                            coastal.question[12].ans.length > 0 &&
                            coastal.question[13].ans.length > 0 &&
                            coastal.question[14].ans.length > 0) {
                          ansStatus = true;
                        }
                      }
                      if (ansStatus == true) {
                        setState(() {
                          _isLoading = true;
                        });

                        Map<String, String> coastalData = Map();
                        // coastalData['COASTAL'] =
                        //     coastal.title.toString();
                        coastalData[coastal.question[0].qus.toString()] =
                            coastal.question[0].ans.toString();
                        coastalData[coastal.question[1].qus.toString()] =
                            coastal.question[1].ans.toString() ?? "";
                        coastalData[coastal.question[2].qus.toString()] =
                            coastal.question[2].ans.toString();
                        coastalData[coastal.question[3].qus.toString()] =
                            coastal.question[3].ans.toString() ?? "";
                        coastalData[coastal.question[4].qus.toString()] =
                            coastal.question[4].ans.toString();
                        coastalData[coastal.question[5].qus.toString()] =
                            coastal.question[5].ans.toString() ?? "";
                        coastalData[coastal.question[6].qus.toString()] =
                            coastal.question[6].ans.toString();
                        coastalData[coastal.question[7].qus.toString()] =
                            coastal.question[7].ans.toString();
                        coastalData[coastal.question[8].qus.toString()] =
                            coastal.question[8].ans.toString();
                        coastalData[coastal.question[9].qus.toString()] =
                            coastal.question[9].ans.toString();
                        coastalData[coastal.question[10].qus.toString()] =
                            coastal.question[10].ans.toString();
                        coastalData[coastal.question[11].qus.toString()] =
                            coastal.question[11].ans.toString();
                        coastalData[coastal.question[12].qus.toString()] =
                            coastal.question[12].ans.toString();
                        coastalData[coastal.question[13].qus.toString()] =
                            coastal.question[13].ans.toString();
                        coastalData[coastal.question[14].qus.toString()] =
                            coastal.question[14].ans.toString();
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();
                        final deviceId = _preferences.getString('D_id');
                        final city = _preferences.getString("city");
                        final surveyId = _preferences.getString('survey_id') ??
                            '${deviceId.toString()}' + 'S1';
                        if (connectivityCheck.isOnline != null) {
                          if (connectivityCheck.isOnline) {
                            coastalData.forEach((key, value) async {
                              await postMethod(
                                  city: city,
                                  surveyId: surveyId,
                                  deviceId: deviceId,
                                  ques: key,
                                  ans: value);
                            });
                            setState(() {
                              _isLoading = false;
                            });
                            print("SERVER SEND");
                            await Navigator.pushNamed(
                                context, '/environmentalRelated_page');
                          } else {
                            coastalData.forEach((key, value) async {
                              await DbHelper.instance.insertData(
                                  answer: value,
                                  city: city,
                                  surveyId: surveyId,
                                  question: key);
                            });

                            setState(() {
                              _isLoading = false;
                            });
                            print("DB INSERT");
                            await Navigator.pushNamed(
                                context, '/environmentalRelated_page');
                          }
                        }
                      } else {
                        showSnackBar();
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading..",
                                style: GoogleFonts.quicksand(fontSize: 18.0),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircularProgressIndicator(
                                color: Colors.white,
                              )
                            ],
                          )
                        : Text("Continue",
                            style: GoogleFonts.quicksand(fontSize: 22.0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    color: Colors.grey,
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      height: 50,
                      minWidth: 250,
                      textColor: Colors.white,
                      child: Text("Back",
                          style: GoogleFonts.quicksand(fontSize: 22.0))),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        )));
  }

  Future postMethod(
      {String deviceId,
      String city,
      String surveyId,
      String ques,
      String ans}) async {
    try {
      var data = {
        "city": city.toString(),
        "device_id": deviceId.toString(),
        "survey_id": surveyId.toString(),
        "question": ques.toString(),
        "answer": ans.toString()
      };
      var response = await http.post(
          Uri.parse(
              'http://13.232.140.106:3030/rsi-field-force-api/user/post-survey'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));

      // print(response.body);
      String id = response.body;
      print("Response====>$id");
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Some Fields are Missing...!',
        style: TextStyle(fontSize: 15),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Hide',
        textColor: Colors.white,
        onPressed: scaffoldKey.currentState.hideCurrentSnackBar,
      ),
    ));
  }

  // sendCoastalData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/coastal'),
  //         body: {
  //           "do_you_have_boats": coastal.question[0].ans,
  //           "purpose_of_using_boatss": coastal.question[1].ans,
  //           "are_you_associated_with_fishing_related_activities":
  //               coastal.question[2].ans,
  //           "role_in_fishing_related_activities": coastal.question[3].ans,
  //           "have_you_been_engaged_in_other_activities_apart_from_fishing":
  //               coastal.question[4].ans,
  //           "other_activities_apart_from_fishing": coastal.question[5].ans,
  //           "think_living_in_a_coastal_region_is_a_threat_an_opportunity":
  //               coastal.question[6].ans,
  //           "how_do_you_get_the_information_related_to_natural_threats":
  //               coastal.question[7].ans,
  //           "safe_place_during_natural_events": coastal.question[8].ans,
  //           "after_disaster_how_many_days_it_take_to_come_to_normal":
  //               coastal.question[9].ans,
  //           "major_damages_during_natural_calamities": coastal.question[10].ans,
  //           "availability_of_ration_during_the_natural_disaster":
  //               coastal.question[11].ans,
  //           "whether_any_fund_area_granted_for_the_flood_prone_area":
  //               coastal.question[12].ans,
  //           "does_this_region_have_any_tourism_opportunities":
  //               coastal.question[13].ans,
  //           "any_further_suggestion_issues": coastal.question[14].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
