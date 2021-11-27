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
import 'package:socio_survey/json%20data/SocialInfrastructure_data.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/slums%20page/slums_page.dart';
import 'package:socio_survey/service/SocialInfrastructureQuestion.dart';
import 'package:http/http.dart' as http;

class SocialInfrastructurePage extends StatefulWidget {
  SocialInfrastructurePage({Key key}) : super(key: key);

  @override
  _SocialInfrastructurePageState createState() =>
      _SocialInfrastructurePageState();
}

class _SocialInfrastructurePageState extends State<SocialInfrastructurePage> {
  SocialInfrastructure socialInfrastructure;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();

  @override
  void initState() {
    var json = socialInfraData;
    socialInfrastructure = SocialInfrastructure.fromJson(json);

    setState(() {
      connectivityCheck.startMonitoring();
      print(socialInfrastructure?.toJson());
      page();
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/socialInfrastructure_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      socialInfrastructure.question[i].ans = val;
    });
  }

  getAns() {
    print(socialInfrastructure.question);
    socialInfrastructure.question.forEach((element) {
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
  List<bool> userStatus2 = [
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

  var tmpArray2 = [];
  final String title = 'Social Infrastructure';
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
                    '${socialInfrastructure.title}',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < socialInfrastructure.question.length; i++)
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
                    i == 12 ||
                    i == 13 ||
                    i == 14 ||
                    i == 11 && socialInfrastructure.question[10].ans == "Yes")
                  Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              socialInfrastructure.question[i].qus.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (socialInfrastructure.question[i].type == Type.RADIO)
                          for (var j = 0;
                              j <
                                  socialInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: socialInfrastructure
                                      .question[i].choice[j]
                                      .toString(),
                                  groupValue:
                                      socialInfrastructure.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(socialInfrastructure.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                socialInfrastructure.question[i].choice[j]
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        if (socialInfrastructure.question[i].type == Type.TEXT)
                          TextField(
                            onChanged: (val) {
                              socialInfrastructure.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (socialInfrastructure.question[i].type ==
                            Type.RADIOWITHTEXT)
                          for (var j = 0;
                              j <
                                  socialInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: socialInfrastructure
                                      .question[i].choice[j]
                                      .toString(),
                                  groupValue:
                                      socialInfrastructure.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(socialInfrastructure.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                socialInfrastructure.question[i].choice[j]
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: socialInfrastructure
                                              .question[i].choice.length -
                                          1 ==
                                      j
                                  ? TextField(
                                      onChanged: (val) {
                                        socialInfrastructure.question[i].ans =
                                            val;
                                        print(socialInfrastructure.question[i]
                                            .toJson());
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter here'),
                                    )
                                  : SizedBox(),
                            ),
                        if (socialInfrastructure.question[i].type ==
                            Type.CHECKBOX)
                          for (var j = 0;
                              j <
                                  socialInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                                title: Text(
                                  socialInfrastructure.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Checkbox(
                                  activeColor: Colors.deepOrange,
                                  value: userStatus[j],
                                  onChanged: (bool value) {
                                    setState(() {
                                      userStatus[j] = value;
                                    });
                                    if (value == true) {
                                      tmpArray.add(socialInfrastructure
                                          .question[i].choice[j]);
                                    }
                                    print("Added --$tmpArray");

                                    String listToString = tmpArray.join(",");
                                    print("joined --$listToString");
                                    socialInfrastructure.question[i].ans =
                                        listToString;
                                  },
                                ),
                                subtitle: TextField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Distance'),
                                  onSubmitted: (val) {
                                    setState(() {
                                      String onchangeValue = val;
                                      print(onchangeValue);
                                      tmpArray.add(onchangeValue.toString());
                                    });

                                    // transportation.question[i].ans = val;
                                    // print(transportation.toJson());
                                  },
                                )),
                        if (socialInfrastructure.question[i].type ==
                            Type.CHECKBOX1)
                          for (var j = 0;
                              j <
                                  socialInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                                title: Text(
                                  socialInfrastructure.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Checkbox(
                                  activeColor: Colors.deepOrange,
                                  value: userStatus1[j],
                                  onChanged: (bool value) {
                                    setState(() {
                                      userStatus1[j] = value;
                                    });
                                    if (value == true) {
                                      tmpArray1.add(socialInfrastructure
                                          .question[i].choice[j]);
                                    }
                                    print("Added --$tmpArray1");

                                    String listToString = tmpArray1.join(",");
                                    print("joined --$listToString");
                                    socialInfrastructure.question[i].ans =
                                        listToString;
                                  },
                                ),
                                subtitle: TextField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Distance'),
                                  onSubmitted: (val) {
                                    setState(() {
                                      String onchangeValue = val;
                                      print(onchangeValue);
                                      tmpArray1.add(onchangeValue.toString());
                                    });

                                    // transportation.question[i].ans = val;
                                    // print(transportation.toJson());
                                  },
                                )),
                        if (socialInfrastructure.question[i].type ==
                            Type.CHECKBOX2)
                          for (var j = 0;
                              j <
                                  socialInfrastructure
                                      .question[i].choice.length;
                              j++)
                            ListTile(
                                title: Text(
                                  socialInfrastructure.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Checkbox(
                                  activeColor: Colors.deepOrange,
                                  value: userStatus2[j],
                                  onChanged: (bool value) {
                                    setState(() {
                                      userStatus2[j] = value;
                                    });
                                    if (value == true) {
                                      tmpArray2.add(socialInfrastructure
                                          .question[i].choice[j]);
                                    }
                                    print("Added --$tmpArray1");

                                    String listToString = tmpArray2.join(",");
                                    print("joined --$listToString");
                                    socialInfrastructure.question[i].ans =
                                        listToString;
                                  },
                                ),
                                subtitle: socialInfrastructure
                                                .question[i].choice.length -
                                            1 ==
                                        j
                                    ? TextField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter Distance'),
                                        onSubmitted: (val) {
                                          setState(() {
                                            String onchangeValue = val;
                                            print(onchangeValue);
                                            tmpArray2
                                                .add(onchangeValue.toString());
                                          });

                                          // transportation.question[i].ans = val;
                                          // print(transportation.toJson());
                                        },
                                      )
                                    : SizedBox())
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
                        x < socialInfrastructure.question.length;
                        x++) {
                      // if (socialInfrastructure.question[x].mandatory == Mandatory.YES) {
                      //   for (var d = 0;
                      //   d < socialInfrastructure.question[x].ans.length;
                      //   d++)
                      //   if (socialInfrastructure.question[x].ans.length <= 13){
                      //       print(x);
                      //   ansStatus = true;
                      //   // print(quesList.question[x].ans);
                      //   }
                      //   else{
                      //     print("======================");
                      //   }

                      // }
                      if (socialInfrastructure.question[0].ans.length > 0 &&
                          socialInfrastructure.question[1].ans.length > 0 &&
                          socialInfrastructure.question[2].ans.length > 0 &&
                          socialInfrastructure.question[3].ans.length > 0 &&
                          socialInfrastructure.question[4].ans.length > 0 &&
                          socialInfrastructure.question[5].ans.length > 0 &&
                          socialInfrastructure.question[6].ans.length > 0 &&
                          socialInfrastructure.question[7].ans.length > 0 &&
                          socialInfrastructure.question[8].ans.length > 0 &&
                          socialInfrastructure.question[9].ans.length > 0 &&
                          socialInfrastructure.question[10].ans.length > 0 &&
                          socialInfrastructure.question[12].ans.length > 0 &&
                          socialInfrastructure.question[13].ans.length > 0) {
                        ansStatus = true;
                      }
                    }
                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> socialData = Map();

                      socialData[
                              socialInfrastructure.question[0].qus.toString()] =
                          socialInfrastructure.question[0].ans.toString();
                      socialData[
                              socialInfrastructure.question[1].qus.toString()] =
                          socialInfrastructure.question[1].ans.toString();
                      socialData[
                              socialInfrastructure.question[2].qus.toString()] =
                          socialInfrastructure.question[2].ans.toString();
                      socialData[
                              socialInfrastructure.question[3].qus.toString()] =
                          socialInfrastructure.question[3].ans.toString();
                      socialData[
                              socialInfrastructure.question[4].qus.toString()] =
                          socialInfrastructure.question[4].ans.toString();
                      socialData[
                              socialInfrastructure.question[5].qus.toString()] =
                          socialInfrastructure.question[5].ans.toString();
                      socialData[
                              socialInfrastructure.question[6].qus.toString()] =
                          socialInfrastructure.question[6].ans.toString();
                      socialData[
                              socialInfrastructure.question[7].qus.toString()] =
                          socialInfrastructure.question[7].ans.toString();
                      socialData[
                              socialInfrastructure.question[8].qus.toString()] =
                          socialInfrastructure.question[8].ans.toString();
                      socialData[
                              socialInfrastructure.question[9].qus.toString()] =
                          socialInfrastructure.question[9].ans.toString();
                      socialData[socialInfrastructure.question[10].qus
                              .toString()] =
                          socialInfrastructure.question[10].ans.toString();
                      socialData[socialInfrastructure.question[11].qus
                              .toString()] =
                          socialInfrastructure.question[11].ans.toString() ??
                              "";
                      socialData[socialInfrastructure.question[12].qus
                              .toString()] =
                          socialInfrastructure.question[12].ans.toString();
                      socialData[socialInfrastructure.question[13].qus
                              .toString()] =
                          socialInfrastructure.question[13].ans.toString();
                      socialData[socialInfrastructure.question[14].qus
                              .toString()] =
                          socialInfrastructure.question[14].ans.toString() ??
                              "";
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      final city = _preferences.getString("city");
                      final deviceId = _preferences.getString('D_id');
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';
                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          socialData.forEach((key, value) async {
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
                          await Navigator.pushNamed(context, '/skip_page');
                        } else {
                          socialData.forEach((key, value) async {
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
                          await Navigator.pushNamed(context, '/skip_page');
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

  // sendSocialData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/social-infrastructure'),
  //         body: {
  //           "type_of_school_infrastructure_do_you_prefer":
  //               socialInfrastructure.question[0].ans,
  //           "type_of_education_availability_distance":
  //               socialInfrastructure.question[1].ans,
  //           "most_preferred_mode": socialInfrastructure.question[2].ans,
  //           "your_region_has_good_opportunities_in_education_facilities":
  //               socialInfrastructure.question[3].ans,
  //           "suggestion_for_educational_improvement":
  //               socialInfrastructure.question[4].ans,
  //           "most_preferred_health_facility":
  //               socialInfrastructure.question[5].ans,
  //           "health_distance": socialInfrastructure.question[6].ans,
  //           "your_region_has_good_opportunities_in_health_facilities":
  //               socialInfrastructure.question[7].ans,
  //           "suggestion_for_health_facilities_improvement":
  //               socialInfrastructure.question[8].ans,
  //           "availablility_of_parks_playground_other_recreation_spaces":
  //               socialInfrastructure.question[9].ans,
  //           "your_family_members_go_to_park_playground":
  //               socialInfrastructure.question[10].ans,
  //           "how_regular": socialInfrastructure.question[11].ans,
  //           "suggestion_for_recreation_space_improvement":
  //               socialInfrastructure.question[12].ans,
  //           "grant_from_any_state_government_flagship_scheme":
  //               socialInfrastructure.question[13].ans,
  //           "other_schemes": socialInfrastructure.question[14].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
