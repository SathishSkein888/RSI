import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/json%20data/culturalHeritage_data.dart';
import 'package:socio_survey/models/CulturalQuestion.dart';
import 'package:socio_survey/pages/Tourism%20Page/tourism_page.dart';

class CulturalAndHeritage extends StatefulWidget {
  CulturalAndHeritage({Key key}) : super(key: key);

  @override
  _CulturalAndHeritageState createState() => _CulturalAndHeritageState();
}

class _CulturalAndHeritageState extends State<CulturalAndHeritage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CulturalHeritage culturalHeritage;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  @override
  void initState() {
    var json = culturalData;
    culturalHeritage = CulturalHeritage.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      page();
      print(culturalHeritage?.toJson());
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/culturalAndHeritage");
  }

  setSelectedRadio(val, i) {
    setState(() {
      culturalHeritage.question[i].ans = val;
    });
  }

  getAns() {
    print(culturalHeritage.question);
    culturalHeritage.question.forEach((element) {
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
  bool _isLoading = false;
  final String title = 'Cultural and Heritage';
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
                      '${culturalHeritage.title}',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < culturalHeritage.question.length; i++)
                  if (i == 0 ||
                      i == 1 ||
                      i == 2 ||
                      i == 3 ||
                      i == 4 ||
                      i == 6 ||
                      i == 7 ||
                      i == 5 && culturalHeritage.question[4].ans == "Yes")
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
                                culturalHeritage.question[i].qus.toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                ),
                              )),
                          if (culturalHeritage.question[i].type == "radio")
                            for (var j = 0;
                                j < culturalHeritage.question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.deepOrangeAccent,
                                    value: culturalHeritage
                                        .question[i].choice[j]
                                        .toString(),
                                    groupValue:
                                        culturalHeritage.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(culturalHeritage.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  culturalHeritage.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                          if (culturalHeritage.question[i].type == "checkbox")
                            for (var j = 0;
                                j < culturalHeritage.question[i].choice.length;
                                j++)
                              ListTile(
                                  title: Text(
                                    culturalHeritage.question[i].choice[j]
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
                                        tmpArray.add(culturalHeritage
                                            .question[i].choice[j]);
                                      }
                                      print("Added --$tmpArray");

                                      String listToString = tmpArray.join(",");
                                      print("joined --$listToString");
                                      culturalHeritage.question[i].ans =
                                          listToString;
                                    },
                                  ),
                                  subtitle: culturalHeritage
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
                                              tmpArray.add(
                                                  onchangeValue.toString());
                                            });

                                            // transportation.question[i].ans = val;
                                            // print(transportation.toJson());
                                          },
                                        )
                                      : SizedBox()),
                          if (culturalHeritage.question[i].type == "checkbox1")
                            for (var x = 0;
                                x < culturalHeritage.question[i].choice.length;
                                x++)
                              ListTile(
                                  title: Text(
                                    culturalHeritage.question[i].choice[x]
                                        .toString(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    activeColor: Colors.deepOrange,
                                    value: userStatus1[x],
                                    onChanged: (bool value) {
                                      setState(() {
                                        userStatus1[x] = value;
                                      });
                                      if (value == true) {
                                        tmpArray1.add(culturalHeritage
                                            .question[i].choice[x]);
                                      }
                                      print("Added --$tmpArray1");

                                      String listToString = tmpArray1.join(",");
                                      print("joined --$listToString");
                                      culturalHeritage.question[i].ans =
                                          listToString;
                                    },
                                  ),
                                  subtitle: culturalHeritage
                                                  .question[i].choice.length -
                                              1 ==
                                          x
                                      ? TextField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter Distance'),
                                          onSubmitted: (val) {
                                            setState(() {
                                              String onchangeValue = val;
                                              print(onchangeValue);
                                              tmpArray1.add(
                                                  onchangeValue.toString());
                                            });
                                            // transportation.question[i].ans = val;
                                            // print(transportation.toJson());
                                          },
                                        )
                                      : SizedBox()),
                          if (culturalHeritage.question[i].type == "text")
                            TextField(
                              onChanged: (val) {
                                culturalHeritage.question[i].ans = val;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter here'),
                            ),
                          if (culturalHeritage.question[i].type ==
                              "radiowithtext")
                            for (var j = 0;
                                j < culturalHeritage.question[i].choice.length;
                                j++)
                              ListTile(
                                leading: Radio(
                                    activeColor: Colors.purpleAccent,
                                    value: culturalHeritage
                                        .question[i].choice[j]
                                        .toString(),
                                    groupValue:
                                        culturalHeritage.question[i].ans,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        setSelectedRadio(val, i);
                                        print(culturalHeritage.toJson());
                                        // value = int.parse(val);
                                      });
                                    }),
                                title: Text(
                                  culturalHeritage.question[i].choice[j]
                                      .toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle:
                                    culturalHeritage.question[i].choice.length -
                                                1 ==
                                            j
                                        ? TextField(
                                            onChanged: (val) {
                                              culturalHeritage.question[i].ans =
                                                  val;
                                              print(culturalHeritage.question[i]
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
                          x < culturalHeritage.question.length;
                          x++) {
                        if (culturalHeritage.question[0].ans.length > 0 &&
                            culturalHeritage.question[1].ans.length > 0 &&
                            culturalHeritage.question[2].ans.length > 0 &&
                            culturalHeritage.question[3].ans.length > 0 &&
                            culturalHeritage.question[4].ans.length > 0 &&
                            //culturalHeritage.question[5].ans.length > 0 &&
                            culturalHeritage.question[6].ans.length > 0 &&
                            culturalHeritage.question[7].ans.length > 0) {
                          ansStatus = true;
                        }
                      }
                      if (ansStatus == true) {
                        setState(() {
                          _isLoading = true;
                        });

                        Map<String, String> culturalData = Map();

                        culturalData[
                                culturalHeritage.question[0].qus.toString()] =
                            culturalHeritage.question[0].ans.toString();
                        culturalData[
                                culturalHeritage.question[1].qus.toString()] =
                            culturalHeritage.question[1].ans.toString();
                        culturalData[
                                culturalHeritage.question[2].qus.toString()] =
                            culturalHeritage.question[2].ans.toString();
                        culturalData[
                                culturalHeritage.question[3].qus.toString()] =
                            culturalHeritage.question[3].ans.toString();
                        culturalData[
                                culturalHeritage.question[4].qus.toString()] =
                            culturalHeritage.question[4].ans.toString();
                        culturalData[
                                culturalHeritage.question[5].qus.toString()] =
                            culturalHeritage.question[5].ans.toString();
                        culturalData[
                                culturalHeritage.question[6].qus.toString()] =
                            culturalHeritage.question[6].ans.toString() ?? "";
                        culturalData[
                                culturalHeritage.question[7].qus.toString()] =
                            culturalHeritage.question[7].ans.toString();
                        SharedPreferences _preferences =
                            await SharedPreferences.getInstance();
                        final deviceId = _preferences.getString('D_id');
                        final city = _preferences.getString("city");
                        final surveyId = _preferences.getString('survey_id') ??
                            '${deviceId.toString()}' + 'S1';
                        if (connectivityCheck.isOnline != null) {
                          if (connectivityCheck.isOnline) {
                            culturalData.forEach((key, value) async {
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
                            await Navigator.pushNamed(context, '/tourism_page');
                          } else {
                            culturalData.forEach((key, value) async {
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
                            await Navigator.pushNamed(context, '/tourism_page');
                          }
                        }
                        //culturalData.forEach((key, value) async {
                        // await await DbHelper.instance.insertData(key, value);

                        //   await postMethod(
                        //       userId: userId,
                        //       deviceId: deviceId,
                        //       ques: key,
                        //       ans: value);
                        // });

                        // await Navigator.pushNamed(context, '/tourism_page');
                        // setState(() {
                        //   _isLoading = false;
                        // });
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
        ),
      ),
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

  // sendCulturalData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/cultural-heritage'),
  //         body: {
  //           "popular_festival_occasion": culturalHeritage.question[0].ans,
  //           "place_have_any_significant_heritage_site_structure_precinit":
  //               culturalHeritage.question[1].ans,
  //           "visitors_during_festival_occasion":
  //               culturalHeritage.question[2].ans,
  //           "problem_during_festival_occasion":
  //               culturalHeritage.question[3].ans,
  //           "festival_heritage_presence_help_you_in_economic_generation":
  //               culturalHeritage.question[4].ans,
  //           "if_yes_specify": culturalHeritage.question[5].ans,
  //           "tourists_visit_this_place_regularly_during_festivals":
  //               culturalHeritage.question[6].ans,
  //           "any_further_suggestion_issues_for_improvement":
  //               culturalHeritage.question[7].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();

//   Future<Database> _initDatabase() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cultural.db');
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE cultural(
//         id INTEGER PRIMARY KEY,
//         title TEXT,
//         question TEXT
//       )
//       ''');
//   }

//   Future<List<CulturalHeritage>> getCultural() async {
//     Database db = await instance.database;
//     var cultural = await db.query('cultural', orderBy: 'title');
//     List<CulturalHeritage> culturalList = cultural.isEmpty
//         ? cultural.map((e) => CulturalHeritage.fromJson(e)).toList()
//         : [];
//     print(culturalList);
//     return culturalList;
//   }
// }
