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
import 'package:socio_survey/json%20data/tourism_data.dart';
import 'package:socio_survey/pages/environmental%20related%20page/environmental_related_page.dart';
import 'package:socio_survey/pages/final%20page/final_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/service/TourismQuestion.dart';
import 'package:http/http.dart' as http;

class TourismPage extends StatefulWidget {
  TourismPage({Key key}) : super(key: key);

  @override
  _TourismPageState createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Tourism tourism;
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    var json = tourismData;
    tourism = Tourism.fromJson(json);

    setState(() {
      connectivityCheck.startMonitoring();
      print(tourism?.toJson());
      page();
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/tourism_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      tourism.question[i].ans = val;
    });
  }

  getAns() {
    print(tourism.question);
    tourism.question.forEach((element) {
      print(element.ans);
    });
  }

  List onChangeList = [];
  bool _isLoading = false;
  final String title = 'Tourism';

  TextEditingController fithQuizController = TextEditingController();
  TextEditingController fithQuizController1 = TextEditingController();
  TextEditingController tenthQuizController = TextEditingController();
  TextEditingController tenthQuizController1 = TextEditingController();
  TextEditingController tenthQuizController2 = TextEditingController();
  TextEditingController twelthQuizController = TextEditingController();
  TextEditingController twelthQuizController1 = TextEditingController();

  String fifthquz;
  String fifthquz1;
  String tenthquz;
  String tenthquz1;
  String tenthquz2;
  String twelthquz;
  String twelthquz1;
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
                    '${tourism.title}',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < tourism.question.length; i++)
                if (i == 0 ||
                    i == 1 ||
                    i == 2 ||
                    i == 4 ||
                    i == 5 ||
                    i == 7 ||
                    i == 8 ||
                    i == 10 ||
                    i == 11 ||
                    i == 12 ||
                    i == 13 ||
                    i == 3 && tourism.question[2].ans == "Yes" ||
                    i == 9 && tourism.question[8].ans == "Yes")
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
                              tourism.question[i].qus.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (tourism.question[i].type == "radio")
                          for (var j = 0;
                              j < tourism.question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value:
                                      tourism.question[i].choice[j].toString(),
                                  groupValue: tourism.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(tourism.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                tourism.question[i].choice[j].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        if (tourism.question[i].type == "text")
                          TextField(
                            onChanged: (val) {
                              tourism.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (tourism.question[i].type == "fifthquiz") fifthQuz(),
                        if (tourism.question[i].type == "tenthquiz")
                          tenthQuiz(),
                        if (tourism.question[i].type == "twelthquiz")
                          twelthQuiz()
                        // ListTile(
                        //     title: Text(
                        //       tourism.question[i].choice[j].toString(),
                        //       style: GoogleFonts.quicksand(
                        //         fontSize: 18,
                        //       ),
                        //     ),
                        //     subtitle: TextField(
                        //       onChanged: (val) {
                        //         onChangeList.add(val);
                        //         print(onChangeList);
                        //         // tourism.question[i].ans = val;
                        //         // print(tourism.question[i].toJson());
                        //       },
                        //       decoration: const InputDecoration(
                        //           border: OutlineInputBorder(),
                        //           hintText: 'Enter here'),
                        //     )

                        //     // tourism.question[i].choice.length - 1 == j
                        //     //     ?

                        //     // : SizedBox(),
                        //     ),
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

                    if (tourism.question[0].ans.length > 0 &&
                        tourism.question[1].ans.length > 0 &&
                        tourism.question[2].ans.length > 0 &&
                        //tourism.question[3].ans.length > 0 &&
                        //tourism.question[4].ans.length > 0 &&
                        tourism.question[5].ans.length > 0 &&
                        //tourism.question[6].ans.length > 0 &&
                        tourism.question[7].ans.length > 0 &&
                        tourism.question[8].ans.length > 0 &&
                        //tourism.question[9].ans.length > 0 &&
                        tourism.question[10].ans.length > 0 &&
                        //tourism.question[11].ans.length > 0 &&
                        tourism.question[12].ans.length > 0 &&
                        tourism.question[13].ans.length > 0 &&
                        fifthCombinedData != null &&
                        // tenthCombinedData != null &&
                        twelthCombinedData != null) {
                      ansStatus = true;
                    }

                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> tourismData = Map();

                      tourismData[tourism.question[0].qus.toString()] =
                          tourism.question[0].ans.toString();
                      tourismData[tourism.question[1].qus.toString()] =
                          tourism.question[1].ans.toString();
                      tourismData[tourism.question[2].qus.toString()] =
                          tourism.question[2].ans.toString();
                      tourismData[tourism.question[3].qus.toString()] =
                          tourism.question[3].ans.toString();
                      tourismData[tourism.question[4].qus.toString()] =
                          "${fifthquz + "," + fifthquz1}";
                      tourismData[tourism.question[5].qus.toString()] =
                          tourism.question[5].ans.toString();
                      tourismData[tourism.question[6].qus.toString()] =
                          tourism.question[6].ans.toString();
                      tourismData[tourism.question[7].qus.toString()] =
                          tourism.question[7].ans.toString();
                      tourismData[tourism.question[8].qus.toString()] =
                          tourism.question[8].ans.toString();
                      tourismData[tourism.question[9].qus.toString()] =
                          "${tenthquz + "," + tenthquz1 + "," + tenthquz2}";
                      tourismData[tourism.question[10].qus.toString()] =
                          tourism.question[10].ans.toString();
                      tourismData[tourism.question[11].qus.toString()] =
                          "${twelthquz + "," + twelthquz1}";
                      tourismData[tourism.question[12].qus.toString()] =
                          tourism.question[12].ans.toString();
                      tourismData[tourism.question[13].qus.toString()] =
                          tourism.question[13].ans.toString();
                      // tourismData[tourism.question[14].qus.toString()] =
                      //     tourism.question[14].ans.toString();
                      // tourismData[tourism.question[15].qus.toString()] =
                      //     tourism.question[15].ans.toString();
                      SharedPreferences _preferences =
                          await SharedPreferences.getInstance();
                      final deviceId = _preferences.getString('D_id');
                      final city = _preferences.getString("city");
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';

                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          tourismData.forEach((key, value) async {
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
                          await Navigator.pushNamed(context, '/final_page');
                        } else {
                          tourismData.forEach((key, value) async {
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
                          await Navigator.pushNamed(context, '/final_page');
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
                      : Text("Submit",
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

  String fifthCombinedData() {
    List combine = [
      {fithQuizController.text, fithQuizController1.text}
    ];

    String finalData = combine.join("");

    return finalData;
  }

  String tenthCombinedData() {
    List combine = [
      {
        tenthQuizController.text,
        tenthQuizController1.text,
        tenthQuizController2.text
      }
    ];
    String finalData = combine.join("");
    return finalData;
  }

  String twelthCombinedData() {
    List combine = [
      {twelthQuizController.text, twelthQuizController1.text}
    ];
    String finalData = combine.join("");
    return finalData;
  }

  Widget fifthQuz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "During tourist season",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    fifthquz = fithQuizController.text;
                  });
                },
                controller: fithQuizController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Lean season",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    fifthquz1 = fithQuizController1.text;
                  });
                },
                controller: fithQuizController1,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
      ),
    );
  }

  Widget tenthQuiz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "Local Mela/ Fair/ Hat or within District:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz = tenthQuizController.text;
                  });
                },
                controller: tenthQuizController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Kolkata Fair or Inter-State:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz1 = tenthQuizController1.text;
                  });
                },
                controller: tenthQuizController1,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "Intra-State or outside state:",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    tenthquz2 = tenthQuizController2.text;
                  });
                },
                controller: tenthQuizController2,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
      ),
    );
  }

  Widget twelthQuiz() {
    return Container(
      // margin: EdgeInsets.all(20),
      // padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          //Text("data"),
          // Text('5. Any other work engagement apart from tourist activity?'),
          ListTile(
            title: Text(
              "Before Covid-19",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                    twelthquz = twelthQuizController.text;
                  });
                },
                controller: twelthQuizController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          ),
          ListTile(
            title: Text(
              "After Covid-19",
              style: GoogleFonts.quicksand(
                fontSize: 18,
              ),
            ),
            subtitle: TextField(
                onChanged: (value) {
                  setState(() {
                     twelthquz1 = twelthQuizController1.text;
                  });
                 
                },
                controller: twelthQuizController1,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter here')),
          )
        ],
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

  // sendTourismData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/tourism'),
  //         body: {
  //           "tourists_come_to_this_region_regularly": tourism.question[0].ans,
  //           "best_season_for_tourist_to_visit_then_why":
  //               tourism.question[1].ans,
  //           "are_you_involved_in_tourist_related_activities":
  //               tourism.question[2].ans,
  //           "which_type_of_activities_you_involved_in": tourism.question[3].ans,
  //           "work_engagement_apart_from_tourist_activity":
  //               tourism.question[4].ans,
  //           "no_of_family_members_engage_in_such_activity":
  //               tourism.question[5].ans,
  //           "if_handicraft_what_item_do_you_sell": tourism.question[6].ans,
  //           "whom_do_you_sell_your_products_to_most_often":
  //               tourism.question[7].ans,
  //           "participate_in_any_mela_for_product_showcase_sell":
  //               tourism.question[8].ans,
  //           "where_then_how_often_do_you_visit_mela": tourism.question[9].ans,
  //           "availabolity_of_training_center_exhibition_center":
  //               tourism.question[10].ans,
  //           "sell_of_product_before_covid19": tourism.question[11].ans,
  //           "sell_of_product_after_covid19": tourism.question[12].ans,
  //           "tourism_sector_helps_economic_growth_of_this_region":
  //               tourism.question[13].ans,
  //           "any_suggestion_for_improvement": tourism.question[14].ans,
  //           "any_further_suggestion_for_improvement": tourism.question[15].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
