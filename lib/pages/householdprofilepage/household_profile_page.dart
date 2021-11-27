import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_state/native_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/json%20data/household_data.dart';
import 'package:socio_survey/pages/householdprofilepage/postdata_household.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/pages/user%20details%20page/userPost.dart';
import 'package:socio_survey/service/HouseHoldQuestion.dart';
import 'package:http/http.dart' as http;

class HouseHoldPofilePage extends StatefulWidget {
  @override
  _HouseHoldPofilePageState createState() => _HouseHoldPofilePageState();
}

class _HouseHoldPofilePageState extends State<HouseHoldPofilePage> {
  // var path = Directory.current.path;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //late Future<List<HouseholdDb>> _householdList;
  DbHelper _dbHelper = DbHelper.instance;
  // Connectivity _connectivity = new Connectivity();
  bool _isOnline;
  int curUserId = 1;
  var dbHelper;
  // HouseholdDb? householdDb;
  static HouseHold quesList = HouseHold();
  int value;
  bool _isLoading = false;
  Dio _dio = Dio();

  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  //SharedPreferences preferences;
  @override
  void initState() {
    // Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    var json = questionData;
    quesList = HouseHold.fromJson(json);
    // List citiesList = json.decode(jsons);
    // final listData = preferences.getStringList('list');
    // print("Printing List of Data: $listData");
    setState(() {
      connectivityCheck.startMonitoring();
      // startMonitoring();
      // print(quesList?.toJson());
      page();
      // getListData();
      // getHouseholdData();
    });
    super.initState();
  }

  // Future getListData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final listData = preferences.getStringList("list");
  //   print("Printing List of Data: $listData");
  // }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/household_profile");
  }

  // getHouseholdData() {
  //   _householdList = DbHelper.instance.();
  // }

  setSelectedRadio(val, i) {
    setState(() {
      quesList.question[i].ans = val;
    });
  }

  subSetSelectedRadio(val, i, l) {
    setState(() {
      quesList.question[i].subqunts[l].ans = val;
    });
  }

  bool isShow = false;
  List<List<dynamic>> csvList = [];
  getAns() {
    print(quesList.question);
    quesList.question.forEach((element) {
      print(element.ans);
      csvList.add(csvList);
    });
  }

  final String title = 'Householf Profile';
  final _formKey = GlobalKey<FormState>();
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
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        quesList.title.toString(),
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  // Text(),

                  for (var i = 0; i < quesList.question.length; i++)
                    if (i == 0 ||
                        i == 3 ||
                        i == 5 ||
                        i == 1 && quesList.question[0].ans == "Yes" ||
                        i == 2 && quesList.question[0].ans == "Yes" ||
                        i == 4 && quesList.question[3].ans == "No")
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
                                  quesList.question[i].qus.toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                  ),
                                )),
                            if (quesList.question[i].type == 'radio')
                              for (var j = 0;
                                  j < quesList.question[i].choices.length;
                                  j++)
                                ListTile(
                                  leading: Radio(
                                      activeColor: Colors.deepOrange,
                                      value: quesList.question[i].choices[j]
                                          .toString(),
                                      groupValue: quesList.question[i].ans,
                                      onChanged: (val) {
                                        setState(() {
                                          quesList.question[i].selected = true;
                                          print(val);
                                          setSelectedRadio(val, i);
                                          print(quesList.toJson());
                                          // value = int.parse(val);
                                        });
                                      }),
                                  title: Text(
                                    quesList.question[i].choices[j].toString(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),

                            if (quesList.question[i].type == 'text')
                              TextField(
                                onChanged: (val) {
                                  // quesList.question[i].selected =
                                  //     true;
                                  quesList.question[i].ans = val;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter here'),
                              ),
                            if (quesList.question[i].type == 'radiowithtext')
                              for (var j = 0;
                                  j < quesList.question[i].choices.length;
                                  j++)
                                ListTile(
                                  leading: Radio(
                                      activeColor: Colors.deepOrange,
                                      value: quesList.question[i].choices[j]
                                          .toString(),
                                      groupValue: quesList.question[i].ans,
                                      onChanged: (val) {
                                        setState(() {
                                          print(val);

                                          setSelectedRadio(val, i);
                                          print(quesList.toJson());
                                          // value = int.parse(val);
                                        });
                                      }),
                                  title: Text(
                                    quesList.question[i].choices[j].toString(),
                                    style: GoogleFonts.quicksand(fontSize: 18),
                                  ),
                                  subtitle: quesList
                                                  .question[i].choices.length -
                                              1 ==
                                          j
                                      ? TextField(
                                          onChanged: (val) {
                                            quesList.question[i].ans = val;
                                            print(
                                                quesList.question[i].toJson());
                                          },
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here'),
                                        )
                                      : SizedBox(),
                                ),
                            /////
                            if (quesList.question[i].type == 'subqus')
                              for (var l = 0;
                                  l < quesList.question[i].subqunts.length;
                                  l++)
                                Container(
                                    margin: EdgeInsets.all(18),
                                    // alignment: Alignment.centerLeft,
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            quesList.question[i].subqunts[l].qus
                                                .toString(),
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18),
                                          )),
                                      if (quesList
                                              .question[i].subqunts[l].type ==
                                          'radio')
                                        for (var m = 0;
                                            m <
                                                quesList.question[i].subqunts[l]
                                                    .choices.length;
                                            m++)
                                          ListTile(
                                            leading: Radio(
                                                activeColor: Colors.deepOrange,
                                                value: quesList.question[i]
                                                    .subqunts[l].choices[m]
                                                    .toString(),
                                                groupValue: quesList.question[i]
                                                    .subqunts[l].ans,
                                                onChanged: (val) {
                                                  setState(() {
                                                    print(val);
                                                    subSetSelectedRadio(
                                                        val, i, l);
                                                    // setSelectedRadio(val, l);
                                                    print(quesList.toJson());
                                                    // value = int.parse(val);
                                                  });
                                                }),
                                            title: Text(
                                              quesList.question[i].subqunts[l]
                                                  .choices[m]
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18),
                                            ),

                                            // subtitle: quesList .question [i]
                                            //             .subqunts [l].type  =
                                            //         Type.RADIO != null?:null
                                            //         &&
                                            //     quesList .question [i].subqunts [l]
                                            //                 .choices .length -
                                            //             1 ==
                                            //         m
                                          ),
                                      // if (quesList.question[i].type == 'checkbox')
                                      //   for (var s = 0;
                                      //       s <
                                      //           quesList
                                      //               .question[i].choices.length;
                                      //       s++)

                                      //   CheckboxListTile(
                                      //     activeColor: Colors.deepOrange,
                                      //     value: checkBox,
                                      //     title: Text(quesList.question[i].choices
                                      //         .toString()),
                                      //     onChanged: (value) {
                                      //       checkBox = value;
                                      //     },
                                      //   ),
                                      if (quesList
                                              .question[i].subqunts[l].type ==
                                          'radiowithtext')

                                        ///
                                        for (var z = 0;
                                            z <
                                                quesList.question[i].subqunts[l]
                                                    .choices.length;
                                            z++)
                                          ListTile(
                                            leading: Radio(
                                                activeColor: Colors.deepOrange,
                                                value: quesList.question[i]
                                                    .subqunts[l].choices[z]
                                                    .toString(),
                                                groupValue: quesList.question[i]
                                                    .subqunts[l].ans,
                                                onChanged: (val) {
                                                  setState(() {
                                                    print(val);
                                                    subSetSelectedRadio(
                                                        val, i, l);

                                                    //setSelectedRadio(val, i);
                                                    //print(quesList.toJson());
                                                    // value = int.parse(val);
                                                  });
                                                }),
                                            title: Text(
                                              quesList.question[i].subqunts[l]
                                                  .choices[z]
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 18),
                                            ),
                                            subtitle: quesList
                                                            .question[i]
                                                            .subqunts[l]
                                                            .choices
                                                            .length -
                                                        1 ==
                                                    z
                                                ? TextField(
                                                    onChanged: (val) {
                                                      quesList
                                                          .question[i]
                                                          .subqunts[l]
                                                          .ans = val;
                                                      print(quesList.question[i]
                                                          .subqunts[l].ans);
                                                      // print(quesList.question[i]
                                                      //     .toJson());
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Enter here'),
                                                  )
                                                : SizedBox(),
                                          ),

                                      ///
                                      // TextField(
                                      //   onChanged: (val) {
                                      //     quesList.question[i].subqunts[l].ans =
                                      //         val;
                                      //     print(quesList.question[i].toJson());
                                      //   },
                                      //   decoration: const InputDecoration(
                                      //       border: OutlineInputBorder(),
                                      //       hintText: 'Enter here'),
                                      // ),
                                    ])),
                          ]))
                    else
                      Container(),

                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Color(0xfff89d4cf),
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        // bool isValidated = false;
                        // print("ques 1 -->${quesList.question[0].ans}");
                        // print("ques 2 -->${quesList.question[1].ans}");
                        // print(
                        //     "ques 3.1 -->${quesList.question[2].subqunts[0].ans}");
                        // print(
                        //     "ques 3.2 -->${quesList.question[2].subqunts[1].ans}");
                        // print(
                        //     "ques 3.3 -->${quesList.question[2].subqunts[2].ans}");
                        // print("ques 4 -->${quesList.question[3].ans}");
                        // print("ques 5 -->${quesList.question[4].ans}");
                        // print("ques 6 -->${quesList.question[5].ans}");

                        // if (quesList.question[0].ans.length > 0 &&
                        //     quesList.question[3].ans.length > 0 &&
                        //     quesList.question[5].ans.length > 0) {
                        //   if (quesList.question[0].ans == 'Yes') {
                        //     if (quesList.question[1].ans.length > 0 &&
                        //         quesList.question[2].subqunts[0].ans.length >
                        //             0 &&
                        //         quesList.question[2].subqunts[1].ans.length >
                        //             0 &&
                        //         quesList.question[2].subqunts[2].ans.length >
                        //             0) {
                        //       isValidated = true;
                        //     } else {
                        //       isValidated = false;
                        //     }
                        //   } else {
                        //     isValidated = true;
                        //   }
                        //   if (quesList.question[3].ans == 'b) No') {
                        //     if (quesList.question[4].ans.length > 0) {
                        //       if (quesList.question[3].ans ==
                        //           "d)If yes or maybe Place / Location") {
                        //         if (quesList.question[3].ans.length > 0) {
                        //           isValidated = true;
                        //         } else {
                        //           isValidated = false;
                        //         }
                        //       }
                        //     } else {
                        //       isValidated = false;
                        //     }
                        //   } else if (quesList.question[4].ans ==
                        //       "d)If other, Specify") {
                        //     if (quesList.question[4].ans.length > 0) {
                        //       isValidated = true;
                        //     }
                        //   } else {
                        //     isValidated = true;
                        //   }
                        // } else {
                        //   isValidated = false;
                        // }
                        // if (isValidated) {
                        //   print('if');
                        //   Map<String, String> householdData = Map();

                        //   householdData[quesList.question[0].qus.toString()] =
                        //       quesList.question[0].ans.toString();
                        //   householdData[quesList.question[1].qus.toString()] =
                        //       quesList.question[1].ans.toString() ?? "";

                        //   householdData[quesList.question[2].subqunts[0].qus
                        //           .toString()] =
                        //       quesList.question[2].subqunts[0].ans.toString() ??
                        //           "";

                        //   householdData[quesList.question[2].subqunts[1].qus
                        //           .toString()] =
                        //       quesList.question[2].subqunts[1].ans.toString() ??
                        //           "";

                        //   householdData[quesList.question[2].subqunts[2].qus
                        //           .toString()] =
                        //       quesList.question[2].subqunts[2].ans.toString() ??
                        //           "";

                        //   householdData[quesList.question[3].qus.toString()] =
                        //       quesList.question[3].ans.toString();
                        //   householdData[quesList.question[4].qus.toString()] =
                        //       quesList.question[4].ans.toString();
                        //   householdData[quesList.question[5].qus.toString()] =
                        //       quesList.question[5].ans.toString() ?? "";

                        //   SharedPreferences _preferences =
                        //       await SharedPreferences.getInstance();
                        //   final deviceId = _preferences.getString('D_id');
                        //   final surveyId =
                        //       _preferences.getString('survey_id') ??
                        //           '${deviceId.toString()}' + 'S1';
                        //   print(deviceId);
                        //   print(surveyId);
                        //   if (connectivityCheck.isOnline != null) {
                        //     if (connectivityCheck.isOnline) {
                        //       householdData.forEach((key, value) async {
                        //         await postMethod(
                        //             surveyId: surveyId,
                        //             deviceId: deviceId,
                        //             ques: key,
                        //             ans: value);
                        //       });
                        //       setState(() {
                        //         _isLoading = false;
                        //       });
                        //       print("SERVER SEND");
                        //       await Navigator.pushNamed(
                        //           context, '/housing_page');
                        //     } else {
                        //       householdData.forEach((key, value) async {
                        //         await DbHelper.instance
                        //             .insertData(surveyId, key, value);
                        //       });
                        //       setState(() {
                        //         _isLoading = false;
                        //       });
                        //       print("DB INSERT");
                        //       await Navigator.pushNamed(
                        //           context, '/housing_page');
                        //     }
                        //   }
                        // } else {
                        //   print('else');
                        //   showSnackBar();
                        // }

                        var ansStatus = false;

                        for (var x = 0; x < quesList.question.length; x++) {
                          if (quesList.question[0].ans.length > 0 &&
                              quesList.question[3].ans.length > 0 &&
                              quesList.question[5].ans.length > 0) {
                            ansStatus = true;
                          }
                        }

                        if (ansStatus == true) {
                          setState(() {
                            _isLoading = true;
                          });

                          Map<String, String> householdData = Map();

                          householdData[quesList.question[0].qus.toString()] =
                              quesList.question[0].ans.toString() ?? "Sathsih";
                          householdData[quesList.question[1].qus.toString()] =
                              quesList.question[1].ans.toString() ?? "Sathish";

                          householdData[quesList.question[2].subqunts[0].qus
                                  .toString()] =
                              quesList.question[2].subqunts[0].ans.toString() ??
                                  null;

                          householdData[quesList.question[2].subqunts[1].qus
                                  .toString()] =
                              quesList.question[2].subqunts[1].ans.toString() ??
                                  null;

                          householdData[quesList.question[2].subqunts[2].qus
                                  .toString()] =
                              quesList.question[2].subqunts[2].ans.toString() ??
                                  null;

                          householdData[quesList.question[3].qus.toString()] =
                              quesList.question[3].ans.toString();
                          householdData[quesList.question[4].qus.toString()] =
                              quesList.question[4].ans.toString() ?? null;
                          householdData[quesList.question[5].qus.toString()] =
                              quesList.question[5].ans.toString();

                          SharedPreferences _preferences =
                              await SharedPreferences.getInstance();
                          final city = _preferences.getString("city");
                          final deviceId = _preferences.getString('D_id');
                          final surveyId =
                              _preferences.getString('survey_id') ??
                                  '${deviceId.toString()}' + 'S1';
                          print(deviceId);
                          print(surveyId);
                          if (connectivityCheck.isOnline != null) {
                            if (connectivityCheck.isOnline) {
                              householdData.forEach((key, value) async {
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
                                  context, '/housing_page');
                            } else {
                              householdData.forEach((key, value) async {
                                if (value == "") value = "Not Answered";
                                await DbHelper.instance.insertData(
                                    answer: value,
                                    city: city,
                                    surveyId: surveyId,
                                    question: key);
                              });
                              // householdData.forEach((key, value) async {
                              //   await DbHelper.instance
                              //       .insertData(surveyId, key, value);
                              // });
                              setState(() {
                                _isLoading = false;
                              });
                              print("DB INSERT");
                              await Navigator.pushNamed(
                                  context, '/housing_page');
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
                          Navigator.popAndPushNamed(context, '/user_details');
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
          ),
        )));
  }

  // Future passData() async {
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   final deviceId = _preferences.getString('deviceid');
  //   final userId = _preferences.getString('userid');
  //   // List<String> listPref = <String>[];
  //   // _preferences.setStringList('list', listPref);
  //   List<HouseHoldPost> userPost = [
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[0].qus.toString(),
  //         answer: quesList.question[0].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[1].qus.toString(),
  //         answer: quesList.question[1].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[2].subqunts[0].qus.toString(),
  //         answer: quesList.question[2].subqunts[0].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[2].subqunts[1].qus.toString(),
  //         answer: quesList.question[2].subqunts[1].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[2].subqunts[2].qus.toString(),
  //         answer: quesList.question[2].subqunts[2].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[2].subqunts[3].qus.toString(),
  //         answer: quesList.question[2].subqunts[3].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[3].qus.toString(),
  //         answer: quesList.question[3].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[4].qus.toString(),
  //         answer: quesList.question[4].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[5].qus.toString(),
  //         answer: quesList.question[5].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[6].qus.toString(),
  //         answer: quesList.question[6].ans.toString()),
  //     HouseHoldPost(
  //         userId: userId,
  //         deviceId: deviceId,
  //         question: quesList.question[7].qus.toString(),
  //         answer: quesList.question[7].ans.toString()),
  //   ];
  //   // listPref.add(userPost);
  //   userPost.forEach((e) async {
  //     // await postMethod(e.deviceId, e.userId, e.question, e.answer);
  //     // listPref.add(e);
  //   });
  // }

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
        'Some Fields Are Missing',
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

  // generateCsv() async {
  //   List<List<String>> data = [
  //     [quesList.title.toString()],
  //     ["QUESTION", "SELECTED"],
  //     [
  //       quesList.question[0].qus.toString(),
  //       quesList.question[0].ans.toString()
  //     ],
  //     [
  //       quesList.question[1].qus.toString(),
  //       quesList.question[1].ans.toString()
  //     ],
  //     [
  //       quesList.question[2].subqunts[0].qus.toString(),
  //       quesList.question[2].subqunts[0].ans.toString()
  //     ],
  //     [
  //       quesList.question[2].subqunts[1].qus.toString(),
  //       quesList.question[2].subqunts[1].ans.toString()
  //     ],
  //     [
  //       quesList.question[2].subqunts[2].qus.toString(),
  //       quesList.question[2].subqunts[2].ans.toString()
  //     ],
  //     [
  //       quesList.question[2].subqunts[3].qus.toString(),
  //       quesList.question[2].subqunts[3].ans.toString()
  //     ],
  //     [
  //       quesList.question[3].qus.toString(),
  //       quesList.question[3].ans.toString()
  //     ],
  //     [
  //       quesList.question[4].qus.toString(),
  //       quesList.question[4].ans.toString()
  //     ],
  //     [
  //       quesList.question[5].qus.toString(),
  //       quesList.question[5].ans.toString()
  //     ],
  //     [
  //       quesList.question[6].qus.toString(),
  //       quesList.question[6].ans.toString()
  //     ],
  //     [
  //       quesList.question[7].qus.toString(),
  //       quesList.question[7].ans.toString()
  //     ],
  //   ];
  //   String csvData = ListToCsvConverter().convert(data);
  //   final String directory = (await getApplicationSupportDirectory()).path;
  //   final path = "$directory/csv-${DateTime.now()}.csv";
  //   print(path);
  //   final File file = File(path);
  //   await file.writeAsString(csvData);
  //   // Navigator.of(context).push(
  //   //   MaterialPageRoute(
  //   //     builder: (_) {
  //   //       return LoadCsvDataScreen(path: path);
  //   //     },
  //   //   ),
  //   // );
  // }

  // sendHouseProfile() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/household-profile'),
  //         body: {
  //           'migrated': quesList.question[0].ans,
  //           'no_of_years_migrated': quesList.question[1].ans,
  //           'place_of_origin': quesList.question[2].subqunts[0].ans,
  //           'migration_type': quesList.question[2].subqunts[1].ans,
  //           'reason_of_migration': quesList.question[2].subqunts[2].ans,
  //           'other_reasons_for_migration':
  //               quesList.question[2].subqunts[3].ans, //
  //           'willing_to_migrate_to_another_place': quesList.question[3].ans,
  //           'another_migrate_place': quesList.question[4].ans, //
  //           'reason_for_not_going_back_to_native': quesList.question[5].ans,
  //           'other_reason_for_not_going_back_to_native': //
  //               quesList.question[6].ans,
  //           'after_covid_willing_to_go_back_to_native':
  //               quesList.question[7].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
