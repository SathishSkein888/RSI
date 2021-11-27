import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/economy_data.dart';
import 'package:socio_survey/models/EconomyQuestions.dart';
import 'package:socio_survey/pages/Transportation%20page/transportation_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';

import 'package:http/http.dart' as http;

class EconomyAndIndustriesPage extends StatefulWidget {
  EconomyAndIndustriesPage({Key key}) : super(key: key);

  @override
  _EconomyAndIndustriesPageState createState() =>
      _EconomyAndIndustriesPageState();
}

class _EconomyAndIndustriesPageState extends State<EconomyAndIndustriesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  bool _isLoading = false;
  Economy economy;
  //Future<List<EconomyDb>> _economyList;
  @override
  void initState() {
    var jsonData = economyData;
    economy = Economy.fromJson(jsonData);
    setState(() {
      connectivityCheck.startMonitoring();
      page();
      // print(economy?.toJson());
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/economyAndIndustries_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      economy.question[i].ans = val;
    });
  }

  getAns() {
    print(economy.question);
    economy.question.forEach((element) {
      print(element.ans);
    });
  }

  // getEconomyData() {
  //   _economyList = EconomyDbHelper.instance.getEconomyList();
  // }

  List ans = [];
  final String title = 'Economy and Industries';
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
                    economy.title.toString(),
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < economy.question.length; i++)
                if (i == 0 ||
                    i == 1 ||
                    i == 4 ||
                    i == 9 ||
                    i == 11 ||
                    i == 12 ||
                    i == 13 ||
                    i == 14 ||
                    i == 16 ||
                    i == 17 ||
                    i == 18 ||
                    i == 19 ||
                    i == 20 ||
                    i == 21 ||
                    i == 22 ||
                    i == 2 &&
                        economy.question[1].ans == "Construction worker" ||
                    i == 3 && economy.question[1].ans == "Industrial worker" ||
                    i == 5 && economy.question[4].ans == "Yes" ||
                    i == 6 && economy.question[4].ans == "Yes" ||
                    i == 7 &&
                        economy.question[6].ans == "Construction worker" ||
                    i == 8 && economy.question[6].ans == "Industrial worker" ||
                    i == 10 && economy.question[9].ans == "Yes" ||
                    i == 15 && economy.question[14].ans == "Yes")
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
                              economy.question[i].qus.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (economy.question[i].type == Type.RADIO)
                          for (var j = 0;
                              j < economy.question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value:
                                      economy.question[i].choice[j].toString(),
                                  groupValue: economy.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      // setSelectedRadio(val, i);
                                      print(economy.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                economy.question[i].choice[j].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        if (economy.question[i].type == Type.TEXT)
                          TextField(
                            onChanged: (val) {
                              economy.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (economy.question[i].type == Type.RADIOWITHTEXT)
                          for (var j = 0;
                              j < economy.question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value:
                                      economy.question[i].choice[j].toString(),
                                  groupValue: economy.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(economy.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                economy.question[i].choice[j].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle:
                                  economy.question[i].choice.length - 1 == j
                                      ? TextField(
                                          onChanged: (val) {
                                            economy.question[i].ans = val;
                                            print(economy.question[i].toJson());
                                          },
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here'),
                                        )
                                      : SizedBox(),
                            ),
                      ],
                    ),
                  )
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
                    for (var x = 0; x < economy.question.length; x++) {
                      if (economy.question[0].ans.length > 0 &&
                          economy.question[1].ans.length > 0 &&
                          economy.question[4].ans.length > 0 &&
                          economy.question[9].ans.length > 0 &&
                          economy.question[11].ans.length > 0 &&
                          economy.question[12].ans.length > 0 &&
                          economy.question[13].ans.length > 0 &&
                          economy.question[14].ans.length > 0 &&
                          economy.question[16].ans.length > 0 &&
                          economy.question[17].ans.length > 0 &&
                          economy.question[18].ans.length > 0 &&
                          economy.question[19].ans.length > 0 &&
                          economy.question[20].ans.length > 0 &&
                          economy.question[21].ans.length > 0 &&
                          economy.question[22].ans.length > 0) {
                        ansStatus = true;
                      }
                    }
                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> economyData = Map();

                      economyData[economy.question[0].qus.toString()] =
                          economy.question[0].ans.toString();
                      economyData[economy.question[1].qus.toString()] =
                          economy.question[1].ans.toString();
                      economyData[economy.question[2].qus.toString()] =
                          economy.question[2].ans.toString() ?? "";
                      economyData[economy.question[3].qus.toString()] =
                          economy.question[3].ans.toString() ?? "";
                      economyData[economy.question[4].qus.toString()] =
                          economy.question[4].ans.toString();
                      economyData[economy.question[5].qus.toString()] =
                          economy.question[5].ans.toString() ?? "";
                      economyData[economy.question[6].qus.toString()] =
                          economy.question[6].ans.toString() ?? "";
                      economyData[economy.question[7].qus.toString()] =
                          economy.question[7].ans.toString() ?? "";
                      economyData[economy.question[8].qus.toString()] =
                          economy.question[8].ans.toString() ?? "";
                      economyData[economy.question[9].qus.toString()] =
                          economy.question[9].ans.toString();
                      economyData[economy.question[10].qus.toString()] =
                          economy.question[10].ans.toString() ?? "";
                      economyData[economy.question[11].qus.toString()] =
                          economy.question[11].ans.toString();
                      economyData[economy.question[12].qus.toString()] =
                          economy.question[12].ans.toString();
                      economyData[economy.question[13].qus.toString()] =
                          economy.question[13].ans.toString();
                      economyData[economy.question[14].qus.toString()] =
                          economy.question[14].ans.toString();
                      economyData[economy.question[15].qus.toString()] =
                          economy.question[15].ans.toString() ?? "";
                      economyData[economy.question[16].qus.toString()] =
                          economy.question[16].ans.toString();
                      economyData[economy.question[17].qus.toString()] =
                          economy.question[17].ans.toString();
                      economyData[economy.question[18].qus.toString()] =
                          economy.question[18].ans.toString();
                      economyData[economy.question[19].qus.toString()] =
                          economy.question[19].ans.toString();
                      economyData[economy.question[20].qus.toString()] =
                          economy.question[20].ans.toString();
                      economyData[economy.question[21].qus.toString()] =
                          economy.question[21].ans.toString();
                      economyData[economy.question[22].qus.toString()] =
                          economy.question[22].ans.toString();
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      final deviceId = _preferences.getString('D_id');
                      final city = _preferences.getString("city");
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';
                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          economyData.forEach((key, value) async {
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
                              context, '/transportation_page');
                        } else {
                          economyData.forEach((key, value) async {
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
                              context, '/transportation_page');
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

  // sendEconomyData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/economy'),
  //         body: {
  //           "user_id": "1",
  //           "employment_engagement_type": economy.question[0].ans,
  //           "occupation": economy.question[1].ans,
  //           "if_construction_work": economy.question[2].ans,
  //           "family_members_working_as_parttime_employees":
  //               economy.question[3].ans,
  //           "industry_type": economy.question[4].ans,
  //           "working_industry": economy.question[5].ans,
  //           "after_covid19_impact_on_job_opportunity": economy.question[6].ans,
  //           "industrial_sector_been_affected_after_covid19":
  //               economy.question[7].ans,
  //           "suggestion_for_how_job_opportunities_can_be_made_available":
  //               economy.question[8].ans,
  //           "family_members_receive_pension,pension": economy.question[9].ans,
  //           "monthly_expenditure": economy.question[10].ans,
  //           "impact_on_monthly_expenditure_after_covid19":
  //               economy.question[11].ans,
  //           "visit_market_before_covid19": economy.question[12].ans,
  //           "visit_market_after_covid19": economy.question[13].ans,
  //           "preferred_way_of_shopping_before_covid19":
  //               economy.question[14].ans,
  //           "preferred_way_of_shopping_after_covid19": economy.question[15].ans,
  //           "how_often_do_you_do_online_shopping": economy.question[16].ans
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // generateCsv() async {
  //   List<List<String>> data = [
  //     ["ECONOMY & INDUSTRIES "],
  //     ["QUESTION", "SELECTED"],
  //     [economy.question[0].qus.toString(), economy.question[0].ans.toString()],
  //     [economy.question[1].qus.toString(), economy.question[1].ans.toString()],
  //     [economy.question[2].qus.toString(), economy.question[2].ans.toString()],
  //     [economy.question[3].qus.toString(), economy.question[3].ans.toString()],
  //     [economy.question[4].qus.toString(), economy.question[4].ans.toString()],
  //     [economy.question[5].qus.toString(), economy.question[5].ans.toString()],
  //     [economy.question[6].qus.toString(), economy.question[6].ans.toString()],
  //     [economy.question[7].qus.toString(), economy.question[7].ans.toString()],
  //     [economy.question[8].qus.toString(), economy.question[8].ans.toString()],
  //     [economy.question[9].qus.toString(), economy.question[9].ans.toString()],
  //     [
  //       economy.question[10].qus.toString(),
  //       economy.question[10].ans.toString()
  //     ],
  //     [
  //       economy.question[11].qus.toString(),
  //       economy.question[11].ans.toString()
  //     ],
  //     [
  //       economy.question[12].qus.toString(),
  //       economy.question[12].ans.toString()
  //     ],
  //     [
  //       economy.question[13].qus.toString(),
  //       economy.question[13].ans.toString()
  //     ],
  //     [
  //       economy.question[14].qus.toString(),
  //       economy.question[14].ans.toString()
  //     ],
  //     [
  //       economy.question[15].qus.toString(),
  //       economy.question[15].ans.toString()
  //     ],
  //     [
  //       economy.question[16].qus.toString(),
  //       economy.question[16].ans.toString()
  //     ],
  //   ];
  //   String csvData = ListToCsvConverter().convert(data);
  //   final String directory = (await getApplicationSupportDirectory()).path;
  //   final path = "$directory/economy-csv-${DateTime.now()}.csv";
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
}
