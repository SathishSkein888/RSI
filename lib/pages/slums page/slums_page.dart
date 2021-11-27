import 'dart:convert';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/table_page.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/json%20data/slums_data.dart';
import 'package:socio_survey/pages/Coastal%20Page/coastal_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:socio_survey/service/SlumsQuestions.dart';
import 'package:http/http.dart' as http;

class SlumsPage extends StatefulWidget {
  SlumsPage({Key key}) : super(key: key);

  @override
  _SlumsPageState createState() => _SlumsPageState();
}

class _SlumsPageState extends State<SlumsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Slums slums;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    var json = slumsData;
    slums = Slums.fromJson(json);

    setState(() {
      connectivityCheck.startMonitoring();
      print(slums?.toJson());
      page();
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/slums_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      slums.question[i].ans = val;
    });
  }

  getAns() {
    print(slums.question);
    slums.question.forEach((element) {
      print(element.ans);
    });
  }

  bool _isLoading = false;
  final String title = 'Slums page';

  // List rows = [];
  // List cols = [
  //   {"title": 'Boy/Girl', 'key': 'gender'},
  //   {"title": 'Type of School', 'key': 'typeOfSchool'},
  //   {"title": 'Age of dropout', 'key': 'dropout'},
  //   {"title": 'Reason', 'key': 'reason'},
  // ];
  // final _editableKey = GlobalKey<EditableState>();

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
                    '${slums.title}',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < slums.question.length; i++)
                if (i == 0 ||
                    i == 1 ||
                    i == 3 ||
                    i == 4 ||
                    i == 5 ||
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
                    i == 24 ||
                    i == 25 ||
                    i == 2 && slums.question[1].ans == "Government" ||
                    i == 6 && slums.question[5].ans == "Yes" ||
                    i == 20 && slums.question[19].ans == "Yes" ||
                    i == 21 && slums.question[19].ans == "Yes" ||
                    i == 22 && slums.question[19].ans == "Yes" ||
                    i == 23 && slums.question[19].ans == "Yes")
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
                              slums.question[i].qus.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            )),
                        if (slums.question[i].type == Type.RADIO)
                          for (var j = 0;
                              j < slums.question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: slums.question[i].choice[j].toString(),
                                  groupValue: slums.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(slums.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                slums.question[i].choice[j].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        if (slums.question[i].type == Type.TEXT)
                          TextField(
                            onChanged: (val) {
                              slums.question[i].ans = val;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter here'),
                          ),
                        if (slums.question[i].type == Type.TABLE)
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TablePage()));
                              },
                              child: Text("Click Here")),
                        if (slums.question[i].type == Type.RADIOWITHTEXT)
                          for (var j = 0;
                              j < slums.question[i].choice.length;
                              j++)
                            ListTile(
                              leading: Radio(
                                  activeColor: Colors.deepOrange,
                                  value: slums.question[i].choice[j].toString(),
                                  groupValue: slums.question[i].ans,
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      setSelectedRadio(val, i);
                                      print(slums.toJson());
                                      // value = int.parse(val);
                                    });
                                  }),
                              title: Text(
                                slums.question[i].choice[j].toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: slums.question[i].choice.length - 1 == j
                                  ? TextField(
                                      onChanged: (val) {
                                        slums.question[i].ans = val;
                                        print(slums.question[i].toJson());
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
                    SharedPreferences _preferences =
                        await SharedPreferences.getInstance();
                    String tableData =
                        _preferences.getString('table') ?? "Not Answered";
                    print("table data $tableData");
                    var ansStatus = false;
                    for (var x = 0; x < slums.question.length; x++) {
                      if (slums.question[0].ans.length > 0 &&
                          slums.question[1].ans.length > 0 &&
                          //slums.question[2].ans.length > 0 &&
                          slums.question[3].ans.length > 0 &&
                          slums.question[4].ans.length > 0 &&
                          slums.question[5].ans.length > 0 &&
                          //slums.question[6].ans.length > 0 &&
                          slums.question[7].ans.length > 0 &&
                          slums.question[8].ans.length > 0 &&
                          slums.question[9].ans.length > 0 &&
                          slums.question[10].ans.length > 0 &&
                          slums.question[11].ans.length > 0 &&
                          slums.question[12].ans.length > 0 &&
                          slums.question[13].ans.length > 0 &&
                          slums.question[14].ans.length > 0 &&
                          slums.question[15].ans.length > 0 &&
                          slums.question[16].ans.length > 0 &&
                          slums.question[17].ans.length > 0 &&
                          slums.question[18].ans.length > 0 &&
                          slums.question[19].ans.length > 0 &&
                          // slums.question[20].ans.length > 0 &&
                          // slums.question[21].ans.length > 0 &&
                          // slums.question[22].ans.length > 0 &&
                          //slums.question[23].ans.length > 0 &&
                          slums.question[24].ans.length > 0 &&
                          slums.question[25].ans.length > 0) {
                        ansStatus = true;
                      }
                    }
                    if (ansStatus == true) {
                      setState(() {
                        _isLoading = true;
                      });

                      Map<String, String> slumsData = Map();

                      slumsData[slums.question[0].qus.toString()] =
                          slums.question[0].ans.toString();
                      slumsData[slums.question[1].qus.toString()] =
                          slums.question[1].ans.toString();
                      slumsData[slums.question[2].qus.toString()] =
                          slums.question[2].ans.toString() ?? "";
                      slumsData[slums.question[3].qus.toString()] =
                          slums.question[3].ans.toString();
                      slumsData[slums.question[4].qus.toString()] =
                          slums.question[4].ans.toString();
                      slumsData[slums.question[5].qus.toString()] =
                          slums.question[5].ans.toString();
                      slumsData[slums.question[6].qus.toString()] =
                          slums.question[6].ans.toString() ?? "";
                      slumsData[slums.question[7].qus.toString()] =
                          slums.question[7].ans.toString();
                      slumsData[slums.question[8].qus.toString()] =
                          slums.question[8].ans.toString();
                      slumsData[slums.question[9].qus.toString()] =
                          slums.question[9].ans.toString();
                      slumsData[slums.question[10].qus.toString()] =
                          slums.question[10].ans.toString();
                      slumsData[slums.question[11].qus.toString()] =
                          slums.question[11].ans.toString();
                      slumsData[slums.question[12].qus.toString()] =
                          slums.question[12].ans.toString();
                      slumsData[slums.question[13].qus.toString()] =
                          slums.question[13].ans.toString();
                      slumsData[slums.question[14].qus.toString()] =
                          slums.question[14].ans.toString();
                      slumsData[slums.question[15].qus.toString()] =
                          slums.question[15].ans.toString();
                      slumsData[slums.question[16].qus.toString()] =
                          slums.question[16].ans.toString();
                      slumsData[slums.question[17].qus.toString()] =
                          slums.question[17].ans.toString();
                      slumsData[slums.question[18].qus.toString()] =
                          slums.question[18].ans.toString();
                      slumsData[slums.question[19].qus.toString()] =
                          slums.question[19].ans.toString();
                      slumsData[slums.question[20].qus.toString()] =
                          // slums.question[20].ans.toString();
                          slums.question[20].ans.toString() ?? "";
                      slumsData[slums.question[21].qus.toString()] =
                          slums.question[21].ans.toString() ?? "";
                      slumsData[slums.question[22].qus.toString()] =
                          slums.question[22].ans.toString() ?? "";
                      slumsData[slums.question[23].qus.toString()] =
                          tableData.toString() ?? "";
                      slumsData[slums.question[24].qus.toString()] =
                          slums.question[24].ans.toString();
                      slumsData[slums.question[25].qus.toString()] =
                          slums.question[25].ans.toString();
                      // if (slumsData.values.length <= 20) {
                      //   print('object');
                      // }
                      // SharedPreferences _preferences =
                      //     await SharedPreferences.getInstance();
                      final deviceId = _preferences.getString('D_id');
                      final city = _preferences.getString("city");
                      final surveyId = _preferences.getString('survey_id') ??
                          '${deviceId.toString()}' + 'S1';
                      if (connectivityCheck.isOnline != null) {
                        if (connectivityCheck.isOnline) {
                          slumsData.forEach((key, value) async {
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
                              context, '/environmentalRelated_page');
                          _preferences.remove('table');
                        } else {
                          slumsData.forEach((key, value) async {
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
                              context, '/environmentalRelated_page');
                          _preferences.remove('table');
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

  // sendSlumsData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/slums'),
  //         body: {
  //           "this_place_is_allotted_to_you_by_any_authority":
  //               slums.question[0].ans,
  //           "status_of_land": slums.question[1].ans,
  //           "is_there_patta": slums.question[2].ans,
  //           "how_long_have_you_stayed_here": slums.question[3].ans,
  //           "types_of_work_you_are_engaged": slums.question[4].ans,
  //           "are_you_skilled_labour": slums.question[5].ans,
  //           "skill_type": slums.question[6].ans,
  //           "due_to_covid19_your_income_job_been_affected":
  //               slums.question[7].ans,
  //           "get_any_ration_assistance_from_government": slums.question[8].ans,
  //           "type_of_ration_card_you_avail": slums.question[9].ans,
  //           "get_any_financial_assitance_from_government":
  //               slums.question[10].ans,
  //           "how_regular": slums.question[11].ans,
  //           "get_any_benefits_from_any_state_central_housing_schemes":
  //               slums.question[12].ans,
  //           "allotted_any_house_under_the_slum_rehabilitation_project":
  //               slums.question[13].ans,
  //           "if_government_provides_house_you_move_to_that_place":
  //               slums.question[14].ans,
  //           "get_any_benefits_of_swasthya_sathi": slums.question[15].ans,
  //           "willing_to_go_back_to_native_if_suitable_jobs_made_available":
  //               slums.question[16].ans,
  //           "life_in_slum_areas": slums.question[17].ans,
  //           "kind_of_problem_do_you_face": slums.question[18].ans,
  //           "face_any_problems_from_industries_around_you":
  //               slums.question[19].ans,
  //           "whether_all_children_enrolled_in_school": slums.question[20].ans,
  //           "student_gender": slums.question[21].ans,
  //           "type_of_school": slums.question[22].ans,
  //           "not_going_dropout_age": slums.question[23].ans,
  //           "reason_of_dropout": slums.question[24].ans,
  //           "suggestion_for_improvement": slums.question[25].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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

  // Widget tableData() {
  //   return Editable(
  //     key: _editableKey,
  //     columns: cols,
  //     rows: rows,
  //     //zebraStripe: true,
  //     // stripeColor1: Colors.blue[50],
  //     //stripeColor2: Colors.grey[200],
  //     onRowSaved: (value) {
  //       print(value);
  //     },
  //     onSubmitted: (value) {
  //       print(value);
  //     },
  //     //borderColor: Color(0xfff89d4cf),
  //     // tdStyle: TextStyle(fontWeight: FontWeight.),
  //     trHeight: 80,
  //     thStyle: TextStyle(fontSize: 15),
  //     thAlignment: TextAlign.center,
  //     thVertAlignment: CrossAxisAlignment.end,
  //     thPaddingBottom: 3,
  //     //showSaveIcon: true,
  //     //saveIconColor: Colors.black,
  //     // showCreateButton: true,
  //     tdAlignment: TextAlign.left,
  //     tdEditableMaxLines: 100, // don't limit and allow data to wrap
  //     tdPaddingTop: 0,
  //     tdPaddingBottom: 14,
  //     tdPaddingLeft: 10,
  //     tdPaddingRight: 8,
  //     focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.blue),
  //         borderRadius: BorderRadius.all(Radius.circular(0))),
  //   );
  // }
}

// class TableData extends StatelessWidget {
//   const TableData({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List rows = [];
//     List cols = [
//       {"title": 'Boy/Girl', 'key': 'gender'},
//       {"title": 'Type of School', 'key': 'typeOfSchool'},
//       {"title": 'Age of dropout', 'key': 'dropout'},
//       {"title": 'Reason', 'key': 'reason'},
//     ];
//     final _editableKey = GlobalKey<EditableState>();
//     return SingleChildScrollView(
//       child: Editable(
//         key: _editableKey,
//         columns: cols,
//         rows: rows,
//         //zebraStripe: true,
//         // stripeColor1: Colors.blue[50],
//         //stripeColor2: Colors.grey[200],
//         onRowSaved: (value) {
//           print(value);
//         },
//         onSubmitted: (value) {
//           print(value);
//         },
//         //borderColor: Color(0xfff89d4cf),
//         // tdStyle: TextStyle(fontWeight: FontWeight.),
//         trHeight: 80,
//         thStyle: TextStyle(fontSize: 15),
//         thAlignment: TextAlign.center,
//         thVertAlignment: CrossAxisAlignment.end,
//         thPaddingBottom: 3,
//         //showSaveIcon: true,
//         //saveIconColor: Colors.black,
//         // showCreateButton: true,
//         tdAlignment: TextAlign.left,
//         tdEditableMaxLines: 100, // don't limit and allow data to wrap
//         tdPaddingTop: 0,
//         tdPaddingBottom: 14,
//         tdPaddingLeft: 10,
//         tdPaddingRight: 8,
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue),
//             borderRadius: BorderRadius.all(Radius.circular(0))),
//       ),
//     );
//   }
// }
