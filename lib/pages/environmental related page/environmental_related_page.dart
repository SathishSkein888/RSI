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
import 'package:socio_survey/json%20data/environmentalRelated_data.dart';
import 'package:socio_survey/models/EnvironmentalQuestion.dart';
import 'package:socio_survey/pages/cultural%20and%20heritage%20page/cultural_and_heritage.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;

class EnvironmentalRelatedPage extends StatefulWidget {
  EnvironmentalRelatedPage({Key key}) : super(key: key);

  @override
  _EnvironmentalRelatedPageState createState() =>
      _EnvironmentalRelatedPageState();
}

class _EnvironmentalRelatedPageState extends State<EnvironmentalRelatedPage> {
  EnvironmentalRelated environmentalRelated;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  @override
  void initState() {
    var json = environmentalData;
    environmentalRelated = EnvironmentalRelated.fromJson(json);

    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(environmentalRelated?.toJson());
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/environmentalRelated_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      environmentalRelated.question[i].ans = val;
    });
  }

  getAns() {
    print(environmentalRelated.question);
    environmentalRelated.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Environment Related page';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
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
                      '${environmentalRelated.title}',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < environmentalRelated.question.length; i++)
                  if (i == 0 ||
                      i == 2 ||
                      i == 3 ||
                      i == 4 ||
                      i == 6 ||
                      i == 8 ||
                      i == 9 ||
                      i == 10 ||
                      i == 11 ||
                      i == 13 ||
                      i == 14 ||
                      i == 1 && environmentalRelated.question[0].ans == "Yes" ||
                      i == 5 && environmentalRelated.question[4].ans == "Yes" ||
                      i == 7 && environmentalRelated.question[4].ans == "Yes" ||
                      i == 12 && environmentalRelated.question[11].ans == "Yes")
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
                                environmentalRelated.question[i].qus.toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                ),
                              )),
                          if (environmentalRelated.question[i].type ==
                              Type.RADIO)
                            for (var j = 0;
                                j <
                                    environmentalRelated
                                        .question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.deepOrange,
                                    value: environmentalRelated
                                        .question[i].choice[j]
                                        .toString(),
                                    groupValue:
                                        environmentalRelated.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(environmentalRelated.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  environmentalRelated.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                          if (environmentalRelated.question[i].type ==
                              Type.TEXT)
                            TextField(
                              onChanged: (val) {
                                environmentalRelated.question[i].ans = val;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter here'),
                            ),
                          if (environmentalRelated.question[i].type ==
                              Type.RADIOWITHTEXT)
                            for (var j = 0;
                                j <
                                    environmentalRelated
                                        .question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.deepOrange,
                                    value: environmentalRelated
                                        .question[i].choice[j]
                                        .toString(),
                                    groupValue:
                                        environmentalRelated.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(environmentalRelated.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  environmentalRelated.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: environmentalRelated
                                                .question[i].choice.length -
                                            1 ==
                                        j
                                    ? TextField(
                                        onChanged: (val) {
                                          environmentalRelated.question[i].ans =
                                              val;
                                          print(environmentalRelated.question[i]
                                              .toJson());
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter here'),
                                      )
                                    : SizedBox(),
                              ),
                        ]))
                  else
                    Container(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    color: Color(0xfff89d4cf),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      var ansStatus = false;
                      for (var x = 0;
                          x < environmentalRelated.question.length;
                          x++) {
                        if (environmentalRelated.question[0].ans.length > 0 &&
                            // environmentalRelated.question[1].ans.length > 0 &&
                            environmentalRelated.question[2].ans.length > 0 &&
                            environmentalRelated.question[3].ans.length > 0 &&
                            environmentalRelated.question[4].ans.length > 0 &&
                            //environmentalRelated.question[5].ans.length > 0 &&
                            environmentalRelated.question[6].ans.length > 0 &&
                            // environmentalRelated.question[7].ans.length > 0 &&
                            environmentalRelated.question[8].ans.length > 0 &&
                            environmentalRelated.question[9].ans.length > 0 &&
                            environmentalRelated.question[10].ans.length > 0 &&
                            environmentalRelated.question[11].ans.length > 0 &&
                            // environmentalRelated.question[12].ans.length > 0 &&
                            environmentalRelated.question[13].ans.length > 0 &&
                            environmentalRelated.question[14].ans.length > 0) {
                          ansStatus = true;
                        }
                      }

                      if (ansStatus == true) {
                        setState(() {
                          _isLoading = true;
                        });

                        Map<String, String> envData = Map();

                        envData[environmentalRelated.question[0].qus
                                .toString()] =
                            environmentalRelated.question[0].ans.toString();
                        envData[environmentalRelated.question[1].qus
                                .toString()] =
                            environmentalRelated.question[1].ans.toString() ??
                                "";
                        envData[environmentalRelated.question[2].qus
                                .toString()] =
                            environmentalRelated.question[2].ans.toString();
                        envData[environmentalRelated.question[3].qus
                                .toString()] =
                            environmentalRelated.question[3].ans.toString();
                        envData[environmentalRelated.question[4].qus
                                .toString()] =
                            environmentalRelated.question[4].ans.toString();
                        envData[environmentalRelated.question[5].qus
                                .toString()] =
                            environmentalRelated.question[5].ans.toString() ??
                                "";
                        envData[environmentalRelated.question[6].qus
                                .toString()] =
                            environmentalRelated.question[6].ans.toString();
                        envData[environmentalRelated.question[7].qus
                                .toString()] =
                            environmentalRelated.question[7].ans.toString() ??
                                "";
                        envData[environmentalRelated.question[8].qus
                                .toString()] =
                            environmentalRelated.question[8].ans.toString();
                        envData[environmentalRelated.question[9].qus
                                .toString()] =
                            environmentalRelated.question[9].ans.toString();
                        envData[environmentalRelated.question[10].qus
                                .toString()] =
                            environmentalRelated.question[10].ans.toString();
                        envData[environmentalRelated.question[11].qus
                                .toString()] =
                            environmentalRelated.question[11].ans.toString();
                        envData[environmentalRelated.question[12].qus
                                .toString()] =
                            environmentalRelated.question[12].ans.toString() ??
                                "";
                        envData[environmentalRelated.question[13].qus
                                .toString()] =
                            environmentalRelated.question[13].ans.toString();
                        envData[environmentalRelated.question[14].qus
                                .toString()] =
                            environmentalRelated.question[14].ans.toString();
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();
                        final deviceId = _preferences.getString('D_id');
                        final city = _preferences.getString("city");
                        final surveyId = _preferences.getString('survey_id') ??
                            '${deviceId.toString()}' + 'S1';

                        if (connectivityCheck.isOnline != null) {
                          if (connectivityCheck.isOnline) {
                            envData.forEach((key, value) async {
                              if (value == "") value = "Not Answered";
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
                                context, '/culturalAndHeritage');
                          } else {
                            envData.forEach((key, value) async {
                              if (value == "") value = "Not Answered";
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
                                context, '/culturalAndHeritage');
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
                        style: GoogleFonts.quicksand(fontSize: 22.0)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
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

  // sendEnvironmentData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/environment-related'),
  //         body: {
  //           "family_nearby_person_suffer_from_diseases_in_last_few_years":
  //               environmentalRelated.question[0].ans,
  //           "diseases": environmentalRelated.question[1].ans,
  //           "family_member_face_any_problem_in_breathing":
  //               environmentalRelated.question[2].ans,
  //           "major_cause_of_pollution": environmentalRelated.question[3].ans,
  //           "face_any_issues_during_rainy_season":
  //               environmentalRelated.question[4].ans,
  //           "issues_in_rainy_season": environmentalRelated.question[5].ans,
  //           "whether_the_area_is_prone_to_flooding_due_to_rains":
  //               environmentalRelated.question[6].ans,
  //           "how_many_days_it_takes_to_normal_condition":
  //               environmentalRelated.question[7].ans,
  //           "during_flooding_is_rehabilitation_center_available":
  //               environmentalRelated.question[8].ans,
  //           "whether_any_funds_granted_to_you_for_such_disaster":
  //               environmentalRelated.question[9].ans,
  //           "do_hoardings_create_any_visual_disturbance_while_driving":
  //               environmentalRelated.question[10].ans,
  //           "does_traffic_movement_noise_an_issue_for_your_locality":
  //               environmentalRelated.question[11].ans,
  //           "suggestion_for_improvement_in_reduction_of_traffic_noise":
  //               environmentalRelated.question[12].ans,
  //           "whether_the_waste_disposed_off_in_nearby_river":
  //               environmentalRelated.question[13].ans,
  //           "suggesstion_for_improvement_in_waste_disposed_off_issue":
  //               environmentalRelated.question[14].ans
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
