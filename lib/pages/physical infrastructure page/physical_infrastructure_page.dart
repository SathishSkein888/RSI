import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/phisicalInfra_data.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/social%20infrastructure%20page/social_infrastructure_page.dart';
import 'package:socio_survey/service/PhisicalInfraQuestion.dart';
import 'package:http/http.dart' as http;

class PhysicalInfrastructurePage extends StatefulWidget {
  PhysicalInfrastructurePage({Key key}) : super(key: key);

  @override
  _PhysicalInfrastructurePageState createState() =>
      _PhysicalInfrastructurePageState();
}

class _PhysicalInfrastructurePageState
    extends State<PhysicalInfrastructurePage> {
  PhysicalInfrastructure physicalInfrastructure;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  @override
  void initState() {
    var json = physicalInfraData;
    physicalInfrastructure = PhysicalInfrastructure.fromJson(json);

    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(physicalInfrastructure?.toJson());
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/physicalInfrastructure_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      physicalInfrastructure.question[i].ans = val;
    });
  }

  getAns() {
    print(physicalInfrastructure.question);
    physicalInfrastructure.question.forEach((element) {
      print(element.ans);
    });
  }

  List<bool> userStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  var tmpArray = [];
  final String title = 'Physical infrastructure';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
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
                    '${physicalInfrastructure.title}',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < physicalInfrastructure.question.length; i++)
                if (i == 0 ||
                    i == 1 ||
                    i == 2 ||
                    i == 3 ||
                    i == 4 ||
                    i == 5 ||
                    i == 6 ||
                    i == 7 ||
                    i == 8 ||
                    i == 9 ||
                    i == 10 ||
                    i == 11 ||
                    i == 13 ||
                    i == 14 ||
                    i == 15 ||
                    i == 16 ||
                    i == 17 ||
                    i == 19 ||
                    i == 20 ||
                    i == 18 &&
                        physicalInfrastructure.question[17].ans ==
                            "Door to Door Collection" ||
                    i == 12 && physicalInfrastructure.question[11].ans == "Yes")
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
                              physicalInfrastructure.question[i].qus.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (physicalInfrastructure.question[i].type ==
                            Type.CHECKBOX)
                          for (var s = 0;
                              s <
                                  physicalInfrastructure
                                      .question[i].choice.length;
                              s++)

                            // for (var l = 0;
                            //     l < housing.question[i].selected.length;
                            //     l++)
                            ListTile(
                              title: Text(
                                physicalInfrastructure.question[i].choice[s]
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Checkbox(
                                activeColor: Colors.deepOrange,
                                value: userStatus[s],
                                onChanged: (bool value) {
                                  setState(() {
                                    userStatus[s] = value;
                                  });
                                  if (value == true) {
                                    tmpArray.add(physicalInfrastructure
                                        .question[i].choice[s]);
                                  }
                                  print("Added --$tmpArray");

                                  String listToString = tmpArray.join(",");
                                  print("joined --$listToString");
                                  physicalInfrastructure.question[i].ans =
                                      listToString;
                                },
                              ),
                              subtitle: physicalInfrastructure
                                              .question[i].choice.length -
                                          1 ==
                                      s
                                  ? TextField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter here'),
                                      onChanged: (val) {
                                        setState(() {
                                          String onchangeValue = val;
                                          print(onchangeValue);
                                          tmpArray
                                              .add(onchangeValue.toString());
                                        });

                                        // transportation.question[i].ans = val;
                                        // print(transportation.toJson());
                                      },
                                    )
                                  : SizedBox(),
                            ),
                        if (physicalInfrastructure.question[i].type ==
                            Type.RADIO)
                          for (var j = 0;
                              j <
                                  physicalInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: physicalInfrastructure
                                      .question[i].choice[j]
                                      .toString(),
                                  groupValue:
                                      physicalInfrastructure.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(physicalInfrastructure.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                physicalInfrastructure.question[i].choice[j]
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        if (physicalInfrastructure.question[i].type ==
                            Type.TEXT)
                          TextField(
                            onChanged: (val) {
                              physicalInfrastructure.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (physicalInfrastructure.question[i].type ==
                            Type.RADIOWITHTEXT)
                          for (var j = 0;
                              j <
                                  physicalInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: physicalInfrastructure
                                      .question[i].choice[j]
                                      .toString(),
                                  groupValue:
                                      physicalInfrastructure.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(physicalInfrastructure.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                physicalInfrastructure.question[i].choice[j]
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: physicalInfrastructure
                                              .question[i].choice.length -
                                          1 ==
                                      j
                                  ? TextField(
                                      onChanged: (val) {
                                        physicalInfrastructure.question[i].ans =
                                            val;
                                        print(physicalInfrastructure.question[i]
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
                        x < physicalInfrastructure.question.length;
                        x++) {
                      if (physicalInfrastructure.question[0].ans.length > 0 &&
                          physicalInfrastructure.question[1].ans.length > 0 &&
                          physicalInfrastructure.question[2].ans.length > 0 &&
                          physicalInfrastructure.question[3].ans.length > 0 &&
                          physicalInfrastructure.question[4].ans.length > 0 &&
                          physicalInfrastructure.question[5].ans.length > 0 &&
                          physicalInfrastructure.question[6].ans.length > 0 &&
                          physicalInfrastructure.question[7].ans.length > 0 &&
                          physicalInfrastructure.question[8].ans.length > 0 &&
                          physicalInfrastructure.question[9].ans.length > 0 &&
                          physicalInfrastructure.question[10].ans.length > 0 &&
                          physicalInfrastructure.question[11].ans.length > 0 &&
                          physicalInfrastructure.question[13].ans.length > 0 &&
                          physicalInfrastructure.question[14].ans.length > 0 &&
                          physicalInfrastructure.question[15].ans.length > 0 &&
                          physicalInfrastructure.question[16].ans.length > 0 &&
                          physicalInfrastructure.question[17].ans.length > 0 &&
                          physicalInfrastructure.question[19].ans.length > 0 &&
                          physicalInfrastructure.question[20].ans.length > 0) {
                        ansStatus = true;
                      }
                    }
                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> phsicalData = Map();

                      phsicalData[physicalInfrastructure.question[0].qus
                              .toString()] =
                          physicalInfrastructure.question[0].ans.toString();
                      phsicalData[physicalInfrastructure.question[1].qus
                              .toString()] =
                          physicalInfrastructure.question[1].ans.toString();
                      phsicalData[physicalInfrastructure.question[2].qus
                              .toString()] =
                          physicalInfrastructure.question[2].ans.toString();
                      phsicalData[physicalInfrastructure.question[3].qus
                              .toString()] =
                          physicalInfrastructure.question[3].ans.toString();
                      phsicalData[physicalInfrastructure.question[4].qus
                              .toString()] =
                          physicalInfrastructure.question[4].ans.toString();
                      phsicalData[physicalInfrastructure.question[5].qus
                              .toString()] =
                          physicalInfrastructure.question[5].ans.toString();
                      phsicalData[physicalInfrastructure.question[6].qus
                              .toString()] =
                          physicalInfrastructure.question[6].ans.toString();
                      phsicalData[physicalInfrastructure.question[7].qus
                              .toString()] =
                          physicalInfrastructure.question[7].ans.toString();
                      phsicalData[physicalInfrastructure.question[8].qus
                              .toString()] =
                          physicalInfrastructure.question[8].ans.toString();
                      phsicalData[physicalInfrastructure.question[9].qus
                              .toString()] =
                          physicalInfrastructure.question[9].ans.toString();
                      phsicalData[physicalInfrastructure.question[10].qus
                              .toString()] =
                          physicalInfrastructure.question[10].ans.toString();
                      phsicalData[physicalInfrastructure.question[11].qus
                              .toString()] =
                          physicalInfrastructure.question[11].ans.toString();
                      phsicalData[physicalInfrastructure.question[12].qus
                              .toString()] =
                          physicalInfrastructure.question[12].ans.toString() ??
                              "";
                      phsicalData[physicalInfrastructure.question[13].qus
                              .toString()] =
                          physicalInfrastructure.question[13].ans.toString();
                      phsicalData[physicalInfrastructure.question[14].qus
                              .toString()] =
                          physicalInfrastructure.question[14].ans.toString();
                      phsicalData[physicalInfrastructure.question[15].qus
                              .toString()] =
                          physicalInfrastructure.question[15].ans.toString();
                      phsicalData[physicalInfrastructure.question[16].qus
                              .toString()] =
                          physicalInfrastructure.question[16].ans.toString();
                      phsicalData[physicalInfrastructure.question[17].qus
                              .toString()] =
                          physicalInfrastructure.question[17].ans.toString();
                      phsicalData[physicalInfrastructure.question[18].qus
                              .toString()] =
                          physicalInfrastructure.question[18].ans.toString() ??
                              "";
                      phsicalData[physicalInfrastructure.question[19].qus
                              .toString()] =
                          physicalInfrastructure.question[19].ans.toString();
                      phsicalData[physicalInfrastructure.question[20].qus
                              .toString()] =
                          physicalInfrastructure.question[20].ans.toString();
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      final deviceId = _preferences.getString('D_id');
                      final city = _preferences.getString("city");
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';
                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          phsicalData.forEach((key, value) async {
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
                              context, '/socialInfrastructure_page');
                        } else {
                          phsicalData.forEach((key, value) async {
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
                              context, '/socialInfrastructure_page');
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
                    child: Text(
                      "Back",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      )),
    );
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
        'Some fields are missing...!',
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

  // sendPhysicalData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/physical-infrastructure'),
  //         body: {
  //           "source_of_drinking_water": physicalInfrastructure.question[0].ans,
  //           "is_connection_available_within_premises":
  //               physicalInfrastructure.question[1].ans,
  //           "frequency_of_municipal_supply":
  //               physicalInfrastructure.question[2].ans,
  //           "duration_of_supply": physicalInfrastructure.question[3].ans,
  //           "quality_of_water": physicalInfrastructure.question[4].ans,
  //           "satisfied_with_the_drinking_water_supply":
  //               physicalInfrastructure.question[5].ans,
  //           "types_of_complaints": physicalInfrastructure.question[6].ans,
  //           "complaints_redresses_time": physicalInfrastructure.question[7].ans,
  //           "source_of_electricity": physicalInfrastructure.question[8].ans,
  //           "electricity_connection": physicalInfrastructure.question[9].ans,
  //           "power_cut_duration": physicalInfrastructure.question[10].ans,
  //           "availability_of_street_light":
  //               physicalInfrastructure.question[11].ans,
  //           "condition_of_street_light":
  //               physicalInfrastructure.question[12].ans,
  //           "type_of_street_light": physicalInfrastructure.question[13].ans,
  //           "availability_of_drainage_line":
  //               physicalInfrastructure.question[14].ans,
  //           "household_waste_water_outlet":
  //               physicalInfrastructure.question[15].ans,
  //           "where_is_rain_water_collected":
  //               physicalInfrastructure.question[16].ans,
  //           "where_is_household_solid_waste_disposed_off":
  //               physicalInfrastructure.question[17].ans,
  //           "door_to_door_collection": physicalInfrastructure.question[18].ans,
  //           "is_solid_waste_segregation_at_household_level":
  //               physicalInfrastructure.question[19].ans
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
