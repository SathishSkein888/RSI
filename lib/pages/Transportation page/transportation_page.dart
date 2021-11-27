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
import 'package:socio_survey/json%20data/economy_data.dart';
import 'package:socio_survey/json%20data/transportation_data.dart';
import 'package:socio_survey/models/transportationQuestion.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/physical%20infrastructure%20page/physical_infrastructure_page.dart';
import 'package:http/http.dart' as http;

class TransportationPage extends StatefulWidget {
  TransportationPage({Key key}) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Transportation transportation;
  TextEditingController _textEditingController = TextEditingController();
  Color valuew;
  @override
  void initState() {
    var json = transportationDataJson;
    transportation = Transportation.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      print(transportation.toJson());
      page();
    });

    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/transportation_page");
  }

  setSelectedRadio({val, i}) {
    setState(() {
      transportation.question[i].ans = val;
    });
  }

  getAns() {
    print(transportation.question);
    transportation.question.forEach((element) {
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
  List<bool> userStatus1 = [
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

  var tmpArray1 = [];

  final String title = 'Transportation';
  bool _isLoading = false;
  bool radiowithtext = true;
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
                    '${transportation.title}',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < transportation.question.length; i++)
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
                    i == 12 ||
                    i == 13 ||
                    i == 14 ||
                    i == 15 ||
                    i == 16 ||
                    i == 17 ||
                    i == 18 ||
                    i == 19 ||
                    i == 20 ||
                    i == 21 ||
                    i == 22 ||
                    i == 23 ||
                    i == 24 ||
                    i == 25 ||
                    i == 27 ||
                    i == 26 && transportation.question[25].ans == "Yes")
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${transportation.question[i].qus}",
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (transportation.question[i].type == Type.RADIO)
                          for (var j = 0;
                              j < transportation.question[i].choice.length;
                              j++)
                            GestureDetector(
                              onTapUp: (val) {
                                setState(() {
                                  transportation.question[i].ans =
                                      transportation.question[i].choice[j];
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: transportation.question[i].ans ==
                                        transportation.question[i].choice[j]
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.deepOrange,
                                            value: transportation
                                                .question[i].choice[j],
                                            groupValue:
                                                transportation.question[i].ans,
                                            onChanged: (value) {
                                              print(value);
                                              setState(() {
                                                setSelectedRadio(
                                                    val: value, i: i);
                                              });
                                              print(transportation
                                                  .toJson()
                                                  .toString());
                                            }),
                                        Text(
                                          transportation.question[i].choice[j],
                                          style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // child: ListTile(
                                //   leading: Radio(
                                //       activeColor: Colors.deepOrange,
                                //       value:
                                //           transportation.question[i].choice[j],
                                //       groupValue:
                                //           transportation.question[i].ans,
                                //       onChanged: (value) {
                                //         setSelectedRadio(value, i);
                                //         print(
                                //             transportation.toJson().toString());
                                //       }),
                                //   title: Text(
                                //     transportation.question[i].choice[j],
                                //     style: GoogleFonts.quicksand(
                                //       fontSize: 18,
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                        if (transportation.question[i].type == Type.CHECKBOX)
                          for (var s = 0;
                              s < transportation.question[i].choice.length;
                              s++)

                            // for (var l = 0;
                            //     l < housing.question[i].selected.length;
                            //     l++)
                            Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    color: userStatus[s]
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        transportation.question[i].choice[s]
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
                                            tmpArray.add(transportation
                                                .question[i].choice[s]);
                                          }
                                          print("Added --$tmpArray");

                                          String listToString =
                                              tmpArray.join(",");
                                          print("joined --$listToString");
                                          transportation.question[i].ans =
                                              listToString;
                                        },
                                      ),
                                      subtitle: transportation.question[i]
                                                      .choice.length -
                                                  1 ==
                                              s
                                          ? TextField(
                                              controller:
                                                  _textEditingController,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Please mention'),
                                              onChanged: (val) {
                                                setState(() {
                                                  userStatus[s] = userStatus[6];
                                                });
                                              },
                                              onSubmitted: (val) {
                                                setState(() {
                                                  tmpArray.add(val.toString());
                                                });

                                                // transportation.question[i].ans = val;
                                                // print(transportation.toJson());
                                              },
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        if (transportation.question[i].type == Type.CHECKBOX1)
                          for (var s = 0;
                              s < transportation.question[i].choice.length;
                              s++)

                            // for (var l = 0;
                            //     l < housing.question[i].selected.length;
                            //     l++)
                            ListTile(
                              title: Text(
                                transportation.question[i].choice[s].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Checkbox(
                                activeColor: Colors.deepOrange,
                                value: userStatus1[s],
                                onChanged: (bool value) {
                                  setState(() {
                                    userStatus1[s] = value;
                                  });
                                  if (value == true) {
                                    tmpArray1.add(
                                        transportation.question[i].choice[s]);
                                  }
                                  print("Added --$tmpArray1");

                                  String listToString = tmpArray1.join(",");
                                  print("joined --$listToString");
                                  transportation.question[i].ans = listToString;
                                },
                              ),
                              subtitle: transportation
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
                                          tmpArray1
                                              .add(onchangeValue.toString());
                                        });

                                        // transportation.question[i].ans = val;
                                        // print(transportation.toJson());
                                      },
                                    )
                                  : SizedBox(),
                            ),
                        if (transportation.question[i].type == Type.TEXT)
                          TextField(
                            onChanged: (val) {
                              transportation.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (transportation.question[i].type ==
                            Type.RADIO_WITH_TEXT)
                          for (var j = 0;
                              j < transportation.question[i].choice.length;
                              j++)
                            GestureDetector(
                              onTapUp: (val) {
                                setState(() {
                                  transportation.question[i].ans =
                                      transportation.question[i].choice[j];
                                });
                              },
                              child: Container(
                                  color: transportation.question[i].ans ==
                                          transportation.question[i].choice[j]
                                      ? Colors.orangeAccent.withAlpha(100)
                                      : Colors.white,
                                  child: ListTile(
                                    leading: Radio(
                                        activeColor: Colors.deepOrange,
                                        value: transportation
                                            .question[i].choice[j],
                                        groupValue:
                                            transportation.question[i].ans,
                                        onChanged: (val) {
                                          setState(() {
                                            setSelectedRadio(val: val, i: i);
                                            print(transportation.toJson());
                                          });
                                        }),
                                    title: Text(
                                      transportation.question[i].choice[j],
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: transportation
                                                    .question[i].choice.length -
                                                1 ==
                                            j
                                        ? Container(
                                            height: 25,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                hoverColor: Colors.white,
                                                border: OutlineInputBorder(),
                                                // hintText: 'Enter here'
                                              ),
                                              onChanged: (val) {
                                                transportation.question[i].ans =
                                                    val;
                                                print(transportation.toJson());
                                              },
                                            ),
                                          )
                                        : SizedBox(),
                                  )),
                            )
                      ],
                    ),
                  ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Color(0xfff89d4cf),
                ),
                child: FlatButton(
                  onPressed: () async {
                    var ansStatus = false;
                    for (var x = 0; x < transportation.question.length; x++) {
                      if (transportation.question[0].ans.length > 0 &&
                          transportation.question[1].ans.length > 0 &&
                          transportation.question[2].ans.length > 0 &&
                          transportation.question[3].ans.length > 0 &&
                          transportation.question[4].ans.length > 0 &&
                          transportation.question[5].ans.length > 0 &&
                          transportation.question[6].ans.length > 0 &&
                          transportation.question[7].ans.length > 0 &&
                          transportation.question[8].ans.length > 0 &&
                          transportation.question[9].ans.length > 0 &&
                          transportation.question[10].ans.length > 0 &&
                          transportation.question[11].ans.length > 0 &&
                          transportation.question[12].ans.length > 0 &&
                          transportation.question[13].ans.length > 0 &&
                          transportation.question[14].ans.length > 0 &&
                          transportation.question[15].ans.length > 0 &&
                          transportation.question[16].ans.length > 0 &&
                          transportation.question[17].ans.length > 0 &&
                          transportation.question[19].ans.length > 0) {
                        print(transportation.question[x].ans);
                        ansStatus = true;
                      }
                    }
                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> transportData = Map();

                      transportData[transportation.question[0].qus.toString()] =
                          transportation.question[0].ans.toString();
                      transportData[transportation.question[1].qus.toString()] =
                          transportation.question[1].ans.toString();
                      transportData[transportation.question[2].qus.toString()] =
                          transportation.question[2].ans.toString();
                      transportData[transportation.question[3].qus.toString()] =
                          transportation.question[3].ans.toString();
                      transportData[transportation.question[4].qus.toString()] =
                          transportation.question[4].ans.toString();
                      transportData[transportation.question[5].qus.toString()] =
                          transportation.question[5].ans.toString();
                      transportData[transportation.question[6].qus.toString()] =
                          transportation.question[6].ans.toString();
                      transportData[transportation.question[7].qus.toString()] =
                          transportation.question[7].ans.toString();
                      transportData[transportation.question[8].qus.toString()] =
                          transportation.question[8].ans.toString();
                      transportData[transportation.question[9].qus.toString()] =
                          transportation.question[9].ans.toString();
                      transportData[
                              transportation.question[10].qus.toString()] =
                          transportation.question[10].ans.toString();
                      transportData[
                              transportation.question[11].qus.toString()] =
                          transportation.question[11].ans.toString();
                      transportData[
                              transportation.question[12].qus.toString()] =
                          transportation.question[12].ans.toString();
                      transportData[
                              transportation.question[13].qus.toString()] =
                          transportation.question[13].ans.toString();
                      transportData[
                              transportation.question[14].qus.toString()] =
                          transportation.question[14].ans.toString();
                      transportData[
                              transportation.question[15].qus.toString()] =
                          transportation.question[15].ans.toString();
                      transportData[
                              transportation.question[16].qus.toString()] =
                          transportation.question[16].ans.toString();
                      transportData[
                              transportation.question[17].qus.toString()] =
                          transportation.question[17].ans.toString();
                      transportData[
                              transportation.question[18].qus.toString()] =
                          transportation.question[18].ans.toString() ?? "";
                      transportData[
                              transportation.question[19].qus.toString()] =
                          transportation.question[19].ans.toString();

                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      final city = _preferences.getString("city");
                      final deviceId = _preferences.getString('D_id');
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';

                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          transportData.forEach((key, value) async {
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
                              context, '/physicalInfrastructure_page');
                        } else {
                          transportData.forEach((key, value) async {
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
                              context, '/physicalInfrastructure_page');
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

  // sendTransportationData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/transportation'),
  //         body: {
  //           "transportation_conveyance_facilities_satisfactory":
  //               transportation.question[0].ans.toString(),
  //           "before_covid19_most_preferred_mode_of_transport":
  //               transportation.question[1].ans.toString(),
  //           "after_covid19_most_preferred_mode_of_transport":
  //               transportation.question[2].ans.toString(),
  //           "self_owned_vehicles": transportation.question[3].ans.toString(),
  //           "mode_of_transportation_for_school_college":
  //               transportation.question[4].ans.toString(),
  //           "mode_of_transportation_for_market_shoppingcenter":
  //               transportation.question[5].ans.toString(),
  //           "mode_of_transportation_for_hospital_healthcare":
  //               transportation.question[6].ans.toString(),
  //           "mode_of_transportation_for_parks_cinema_mall":
  //               transportation.question[7].ans.toString(),
  //           "mode_of_transportation_for_railwaystation_bus":
  //               transportation.question[8].ans.toString(),
  //           "mode_of_transportation_for_terminal":
  //               transportation.question[9].ans.toString(),
  //           "mode_of_transportation_for_airport":
  //               transportation.question[10].ans.toString(),
  //           "mode_of_transportation_for_bank_postoffice":
  //               transportation.question[11].ans.toString(),
  //           "how_often_do_you_travel_outstation":
  //               transportation.question[12].ans.toString(),
  //           "oustation_location": transportation.question[13].ans.toString(),
  //           "preferred_mode_of_transportation":
  //               transportation.question[14].ans.toString(),
  //           "are_there_any_signages_provided":
  //               transportation.question[15].ans.toString(),
  //           "is_there_any_footpath_provided":
  //               transportation.question[16].ans.toString(),
  //           "is_zebra_crossing_provided_near_junctions":
  //               transportation.question[17].ans.toString(),
  //           "availability_of_cycle_track_pedestrain_pathway":
  //               transportation.question[18].ans.toString(),
  //           "is_the_path_shaded_with_trees":
  //               transportation.question[19].ans.toString(),
  //           "any_further_suggestion_for_improvement":
  //               transportation.question[20].ans.toString()
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
