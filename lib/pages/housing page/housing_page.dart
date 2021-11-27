import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/dbHelper.dart';
import 'package:socio_survey/json%20data/housing_data.dart';
import 'package:socio_survey/service/HousingQuestion.dart';
import 'package:http/http.dart' as http;

class HousingPage extends StatefulWidget {
  HousingPage({Key key}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  TextEditingController othersSpcify = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Housing housing;

  bool selectedCheckBox = false;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  bool isShow = false;
  String listToString;
  String combine;
  @override
  void initState() {
    //Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();

    var json = housingData;
    housing = Housing.fromJson(json);
    setState(() {
      connectivityCheck.startMonitoring();
      //print(housing?.toJson());
      page();
    });
    super.initState();
  }

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/housing_page");
  }

  setSelectedRadio(val, i) {
    setState(() {
      housing.question[i].ans = val;
    });
  }

  subSetSelectedRadio(val, i, l) {
    setState(() {
      housing.question[i].subqunts[l].ans = val;
    });
  }

  bool showOthersQuis = false;

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

  var tmpArray = [];
  var tmpArray1 = [];
  String onChagedValue;
  final String title = 'Housing page';
  bool _isLoading = false;
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${housing.title}',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  for (var i = 0; i < housing.question.length; i++)
                    if (i == 0 ||
                        i == 1 ||
                        i == 2 ||
                        i == 3 ||
                        i == 4 ||
                        i == 5 ||
                        i == 7 ||
                        i == 8 ||
                        i == 9 ||
                        i == 12 ||
                        i == 13 ||
                        i == 14 ||
                        // i == 15 ||
                        i == 6 && housing.question[5].ans == "Rented" ||
                        i == 10 && housing.question[9].ans == "Yes" ||
                        i == 11 && housing.question[9].ans == "No")
                      // if (i == 5 ||
                      //     i == 9 ||
                      //     i == 6 && housing.question[5].ans == "Rented" ||
                      //     i == 10 && housing.question[9].ans == "Yes" ||
                      //     i == 11 && housing.question[9].ans == "No")
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
                                  "${housing.question[i].qus}",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                  ),
                                )),
                            if (housing.question[i].type == "radio")
                              for (var j = 0;
                                  j < housing.question[i].choices.length;
                                  j++)
                                ListTile(
                                  leading: Radio(
                                      activeColor: Colors.deepOrange,
                                      value: housing.question[i].choices[j],
                                      groupValue: housing.question[i].ans,
                                      onChanged: (value) {
                                        setSelectedRadio(value, i);
                                        print(housing.toJson().toString());
                                      }),
                                  title: Text(
                                    housing.question[i].choices[j],
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                            if (housing.question[i].type == 'checkbox')
                              for (var s = 0;
                                  s < housing.question[i].choices.length;
                                  s++)

                                // for (var l = 0;
                                //     l < housing.question[i].selected.length;
                                //     l++)
                                ListTile(
                                  title: Text(
                                    housing.question[i].choices[s].toString(),
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
                                        tmpArray.add(
                                            housing.question[i].choices[s]);
                                      }
                                      print("Added --$tmpArray");

                                      String listToString = tmpArray.join(",");
                                      print("joined --$listToString");
                                      housing.question[i].ans = listToString;
                                    },
                                  ),
                                ),
                            if (housing.question[i].type == 'checkbox1')
                              for (var s = 0;
                                  s < housing.question[i].choices.length;
                                  s++)
                                Column(
                                  children: [
                                    // if (housing.question[i].choices[s] ==
                                    //         "Other Specify:" &&
                                    //     true)
                                    //   otherSpecify(),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       housing.question[i].choices[s]
                                    //           .toString(),
                                    //       style: GoogleFonts.quicksand(
                                    //         fontSize: 18,
                                    //       ),
                                    //     ),
                                    //     Checkbox(
                                    //       activeColor: Colors.deepOrange,
                                    //       value: userStatus1[s],
                                    //       onChanged: (bool value) {
                                    //         if (housing.question[i]
                                    //                     .choices[s] ==
                                    //                 "Other Specify:" &&
                                    //             true) otherSpecify();
                                    //         //   housing.question[i].choices[s]

                                    //         //     else if(housing.question[i].choices[s]==value)
                                    //         setState(() {
                                    //           userStatus1[s] = value;
                                    //         });
                                    //         if (value == true) {
                                    //           tmpArray1.add(housing
                                    //               .question[i].choices[s]);
                                    //         }
                                    //         print("Added --$tmpArray1");

                                    //         String listToString =
                                    //             tmpArray1.join(",");
                                    //         print("joined --$listToString");
                                    //         housing.question[i].ans =
                                    //             listToString;
                                    //       },
                                    //     ),
                                    //   ],
                                    // )

                                    ListTile(
                                      title: Text(
                                        housing.question[i].choices[s]
                                            .toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                        ),
                                      ),
                                      trailing: Checkbox(
                                        activeColor: Colors.deepOrange,
                                        value: userStatus1[s],
                                        onChanged: (bool value) {
                                          setState(() {
                                            if (housing.question[i].choices
                                                        .length -
                                                    1 ==
                                                s) {
                                              if (userStatus1[s] == true) {
                                                tmpArray1
                                                    .add(othersSpcify.text);
                                              }
                                            } else {
                                              if (value == true) {
                                                tmpArray1.add(housing
                                                    .question[i].choices[s]);
                                              }
                                            }
                                            if (housing.question[i].choices
                                                        .length -
                                                    1 ==
                                                s) {
                                              showOthersQuis = true;
                                              userStatus1[s] = value;
                                              // tmpArray1.add(othersSpcify.text);
                                              // if (othersSpcify.text == null &&
                                              //     othersSpcify.text.isEmpty) {
                                              //   userStatus1[s] = value;
                                              //   showOthersQuis = true;
                                              // } else {
                                              //   alertTextField();
                                              //   print("please Enter the value");
                                              // }
                                            } else {
                                              userStatus1[s] = value;
                                            }
                                          });

                                          print("Added --$tmpArray1");

                                          listToString = tmpArray1.join(",");
                                          print("joined --$listToString");
                                          housing.question[i].ans =
                                              listToString;
                                        },
                                      ),
                                      subtitle:
                                          housing.question[i].choices.length -
                                                      1 ==
                                                  s
                                              ? Visibility(
                                                  visible: showOthersQuis,
                                                  child: TextField(
                                                    controller: othersSpcify,
                                                    onChanged: (val) {
                                                      print(othersSpcify.text);
                                                      // tmpArray1
                                                      //     .add(othersSpcify.text);
                                                      // if(othersSpcify != null){

                                                      // }
                                                      // setState(() {
                                                      //   tmpArray1
                                                      //       .add(othersSpcify.text);
                                                      //   //onChagedValue = val;
                                                      // });
                                                      //  print(onChagedValue);
                                                      //print(housing.toJson());
                                                    },
                                                  ),
                                                )
                                              : SizedBox(),
                                    )
                                  ],
                                ),
                            if (housing.question[i].type == "text")
                              TextField(
                                onChanged: (val) {
                                  housing.question[i].ans = val;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter here'),
                              ),
                            if (housing.question[i].type == "subqusChoice")
                              for (var q = 0;
                                  q < housing.question[i].choices.length;
                                  q++)
                                ListTile(
                                    leading: Radio(
                                        activeColor: Colors.deepOrange,
                                        value: housing.question[i].choices[q],
                                        groupValue: housing.question[i].ans,
                                        onChanged: (val) {
                                          setState(() {
                                            setSelectedRadio(val, i);
                                            print(housing.toJson());
                                          });
                                        }),
                                    title: Text(
                                      housing.question[i].choices[q],
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                      ),
                                    )),
                            if (housing.question[i].type == "textnumber")
                              TextField(
                                onChanged: (val) {
                                  housing.question[i].ans = val;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter here'),
                              ),
                            if (housing.question[i].type == "subqusChoice")
                              for (var z = 0;
                                  z < housing.question[i].subqunts.length;
                                  z++)
                                Container(
                                    margin: EdgeInsets.all(18),
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(housing
                                              .question[i].subqunts[z].qus
                                              .toString())),
                                      // Radio(
                                      //     activeColor: Colors.purpleAccent,
                                      //     value: housing
                                      //         .question [i].subqunts [z].qus
                                      //         .toString(),
                                      //     groupValue:
                                      //         housing .question [i].subqunts [z].ans,
                                      //     onChanged: (val) {
                                      //       setState(() {
                                      //         print(val);
                                      //         subSetSelectedRadio(val, i, z);
                                      //         // setSelectedRadio(val, l);
                                      //         print(housing .toJson());
                                      //         // value = int.parse(val);
                                      //       });
                                      //     }),
                                      if (housing
                                              .question[i].subqunts[z].type ==
                                          'radio')
                                        for (var m = 0;
                                            m <
                                                housing.question[i].subqunts[z]
                                                    .choices.length;
                                            m++)
                                          ListTile(
                                            leading: Radio(
                                                activeColor: Colors.deepOrange,
                                                value: housing.question[i]
                                                    .subqunts[z].choices[m]
                                                    .toString(),
                                                groupValue: housing.question[i]
                                                    .subqunts[z].ans,
                                                onChanged: (val) {
                                                  setState(() {
                                                    print(val);
                                                    subSetSelectedRadio(
                                                        val, i, z);
                                                    // setSelectedRadio(val, l);
                                                    print(housing.toJson());
                                                    // value = int.parse(val);
                                                  });
                                                }),
                                            title: Text(
                                              housing.question[i].subqunts[z]
                                                  .choices[m]
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                      if (housing
                                              .question[i].subqunts[z].type ==
                                          'text')
                                        TextField(
                                          onChanged: (val) {
                                            housing.question[i].ans = val;
                                            print(housing.question[i].toJson());
                                          },
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here'),
                                        ),
                                    ])),
                            if (housing.question[i].type == "radioWithText")
                              for (var j = 0;
                                  j < housing.question[i].choices.length;
                                  j++)
                                ListTile(
                                  leading: Radio(
                                      activeColor: Colors.deepOrange,
                                      value: housing.question[i].choices[j],
                                      groupValue: housing.question[i].ans,
                                      onChanged: (val) {
                                        setState(() {
                                          setSelectedRadio(val, i);
                                          print(housing.toJson());
                                        });
                                      }),
                                  title: Text(
                                    housing.question[i].choices[j],
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle:
                                      housing.question[i].choices.length - 1 ==
                                              j
                                          ? TextField(
                                              onChanged: (val) {
                                                housing.question[i].ans = val;
                                                print(housing.toJson());
                                              },
                                            )
                                          : SizedBox(),
                                ),
                            if (housing.question[i].type == 'subqus')
                              for (var l = 0;
                                  l < housing.question[i].subqunts.length;
                                  l++)
                                Container(
                                    margin: EdgeInsets.all(18),
                                    // alignment: Alignment.centerLeft,
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            housing.question[i].subqunts[l].qus
                                                .toString(),
                                            style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                            ),
                                          )),
                                      if (housing
                                              .question[i].subqunts[l].type ==
                                          'radioWithText')
                                        for (var m = 0;
                                            m <
                                                housing.question[i].subqunts[l]
                                                    .choices.length;
                                            m++)
                                          ListTile(
                                            leading: Radio(
                                                activeColor: Colors.deepOrange,
                                                value: housing.question[i]
                                                    .subqunts[l].choices[m]
                                                    .toString(),
                                                groupValue: housing.question[i]
                                                    .subqunts[l].ans,
                                                onChanged: (val) {
                                                  setState(() {
                                                    print(val);
                                                    subSetSelectedRadio(
                                                        val, i, l);
                                                    // setSelectedRadio(val, l);
                                                    print(housing.toJson());
                                                    // value = int.parse(val);
                                                  });
                                                }),
                                            title: Text(
                                              housing.question[i].subqunts[l]
                                                  .choices[m]
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: housing
                                                            .question[i]
                                                            .subqunts[l]
                                                            .choices
                                                            .length -
                                                        1 ==
                                                    m
                                                ? TextField(
                                                    onChanged: (val) {
                                                      housing.question[i].ans =
                                                          val;
                                                      print(housing.question[i]
                                                          .toJson());
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
                                      if (housing
                                              .question[i].subqunts[l].type ==
                                          'text')
                                        TextField(
                                          onChanged: (val) {
                                            housing.question[i].ans = val;
                                            print(housing.question[i].toJson());
                                          },
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter here'),
                                        ),
                                    ])),
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
                        if (othersSpcify.text != null &&
                            othersSpcify.text.isNotEmpty) {
                          // tmpArray1.add(othersSpcify.text);
                          combine = listToString + "," + othersSpcify.text;
                          print('printing $combine');
                        } else {
                          alertTextField();
                        }
                        var ansStatus = false;
                        for (var x = 0; x < housing.question.length; x++) {
                          if (housing.question[0].ans.length > 0 &&
                              housing.question[1].ans.length > 0 &&
                              housing.question[2].subqunts[0].ans.length > 0 &&
                              housing.question[2].subqunts[1].ans.length > 0 &&
                              housing.question[3].ans.length > 0 &&
                              housing.question[4].ans.length > 0 &&
                              housing.question[5].ans.length > 0 &&
                              housing.question[7].ans.length > 0 &&
                              housing.question[8].ans.length > 0 &&
                              housing.question[9].ans.length > 0 &&
                              housing.question[13].ans.length > 0 &&
                              housing.question[14].ans.length > 0) {
                            ansStatus = true;
                          }
                        }
                        if (ansStatus == true) {
                          setState(() {
                            _isLoading = true;
                          });

                          Map<String, String> housingData = Map();

                          housingData[housing.question[0].qus.toString()] =
                              housing.question[0].ans.toString();
                          housingData[housing.question[1].qus.toString()] =
                              housing.question[1].ans.toString();
                          housingData[housing.question[2].subqunts[0].qus
                                  .toString()] =
                              housing.question[2].subqunts[0].ans.toString();
                          housingData[housing.question[2].subqunts[1].qus
                                  .toString()] =
                              housing.question[2].subqunts[1].ans.toString();
                          housingData[housing.question[3].qus.toString()] =
                              housing.question[3].ans.toString();
                          housingData[housing.question[4].qus.toString()] =
                              housing.question[4].ans.toString();
                          housingData[housing.question[5].qus.toString()] =
                              housing.question[5].ans.toString();
                          housingData[housing.question[6].qus.toString()] =
                              housing.question[6].ans.toString() ?? "";
                          housingData[housing.question[7].qus.toString()] =
                              housing.question[7].ans.toString();
                          housingData[housing.question[8].qus.toString()] =
                              housing.question[8].ans.toString();
                          housingData[housing.question[9].qus.toString()] =
                              housing.question[9].ans.toString();
                          housingData[housing.question[10].qus.toString()] =
                              housing.question[10].ans.toString() ?? "";
                          housingData[housing.question[11].qus.toString()] =
                              housing.question[11].ans.toString() ?? "";
                          housingData[housing.question[12].qus.toString()] =
                              // housing.question[12].ans.toString() ?? "";
                              combine;
                          housingData[housing.question[13].qus.toString()] =
                              housing.question[13].ans.toString();
                          housingData[housing.question[14].qus.toString()] =
                              housing.question[14].ans.toString();
                          SharedPreferences _preferences =
                              await SharedPreferences.getInstance();
                          final city = _preferences.getString("city");
                          final deviceId = _preferences.getString('D_id');
                          final surveyId =
                              _preferences.getString('survey_id') ??
                                  '${deviceId.toString()}' + 'S1';

                          if (connectivityCheck.isOnline != null) {
                            if (connectivityCheck.isOnline) {
                              housingData.forEach((key, value) async {
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
                                  context, '/economyAndIndustries_page');
                            } else {
                              housingData.forEach((key, value) async {
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
                                  context, '/economyAndIndustries_page');
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
          ),
        )));
  }

  Widget otherSpecifyFun() {
    return TextField(
      controller: othersSpcify,
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
        'Some fields are Missing...!',
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

  void alertTextField() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Please Fill textfield...!',
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
  // sendHouseProfile() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://192.168.12.69:3000/socio-economic-survey-api/user/housing'),
  //         body: {
  //           'house_type': housing.question[0].ans,
  //           'no_of_floors': housing.question[1].ans,
  //           'wall_material_used': housing.question[2].subqunts[0].ans,
  //           'roof_material_used': housing.question[2].subqunts[1].ans,
  //           'house_age': housing.question[3].ans,
  //           'house_condition': housing.question[4].ans, //
  //           'ownership_type': housing.question[5].ans,
  //           'rent_amount': housing.question[6].ans, //
  //           'land_ownership': housing.question[7].ans,
  //           'approx_price_range_of_land_per_katha': //
  //               housing.question[8].ans,
  //           'other_land_property': housing.question[9].ans,
  //           'where_is_the_land': housing.question[10].ans,
  //           'are_you_willing_to_buy': housing.question[11].ans,
  //           'usage_of_residential_building': housing.question[12].ans,
  //           'assets_owned_by_household': housing.question[13].ans,
  //           'cooking_fuel': housing.question[14].ans,
  //         });
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
