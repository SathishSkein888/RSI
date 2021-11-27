import 'dart:async';
import 'dart:convert' as cnv;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/completed_page.dart';
import 'package:socio_survey/components/connectivity_check.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/get_data.dart';
import 'package:socio_survey/components/getdevice_id.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/pages/user%20details%20page/user_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/user%20details%20page/userdetails_api.dart';

class LandingPage extends StatefulWidget {
  static String route = "/splashscreen";
  LandingPage({Key key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  Timer _timer;
  ConnectivityCheck connectivityCheck = ConnectivityCheck();
  Dio _dio = Dio();
  var deviceID;
  bool newUser = false;
  @override
  void initState() {
    connectivityCheck.startMonitoring();
    dioPost();

    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  Future getId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final surveyID = _pref.getInt("userid");
    if (surveyID != null) {
      final deviceId = _pref.getString('D_id');
      int userId = _pref.get("userid");
      String surveyId = "${deviceId + "S" + userId.toString()}";
      _pref.setString("survey_id", surveyId);
      final sID = _pref.getString('survey_id');
      print("Survey Id Is :$sID");
      // print("Survey ID is: $surveyID");
    } else {
      _pref.setInt("userid", 1);
      print("New Survey ID Created: $surveyID");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Center(child: Image.asset('assets/images/splash.png')),
              // SizedBox(
              //   height: 25,
              // ),
              // Center(
              //   child: Text(
              //     "RSI FieldForce",
              //     style: GoogleFonts.quicksand(
              //       color: Color(0xfff89d4cf),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 48,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      final page = preferences.getString('page');
                      final dId = preferences.getString('D_id');
                      if (dId == null) {
                        await EasyLoading.showInfo(
                            'Device ID Must be Generate\n Connect Internet and restart the app');
                      } else if (page != null) {
                        await EasyLoading.showInfo(
                            'Need to Complete Missed Survey..!\n Click Continue Survey');
                      } else {
                        getId();
                        // final dId =
                        //     preferences.getString('deviceid');
                        // final uId =
                        //     preferences.getString('userid');
                        // if (dId != null) {
                        //   print('DeviceId is Already there $dId');
                        // } else {
                        //   setState(() {
                        //     deviceId();
                        //   });
                        //   print('New DeviceId is $dId');
                        // }
                        // if (uId != null) {
                        //   print('UserId is Already there $uId');
                        // } else {
                        //   setState(() {
                        //     userId();
                        //   });
                        //   print('New UserId is $uId');
                        // }
                        Navigator.pushNamed(context, '/cities_page');
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Take New Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),

              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {
                      _timer?.cancel();

                      await EasyLoading.show(
                        status: 'Retrieving Survey...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      final page = preferences.getString('page');
                      // final deviceId =
                      //     preferences.getString('deviceid');
                      // final userId =
                      //     preferences.getString('userid');
                      // final pageData =
                      //     preferences.getString('userlist');
                      // final List<UserDetailsApi> users =
                      //     UserDetailsApi.decode(pageData);
                      // print(users);
                      if (page != null) {
                        Navigator.pushNamed(context, page);
                        await EasyLoading.showSuccess('Open Successfully..!');
                        // EasyLoading.dismiss();
                      } else {
                        await EasyLoading.showInfo(
                            'No OnGoing Task..!\n Take New Survey');

                        // EasyLoading.dismiss();
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Continue Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.grey,
                ),
                child: FlatButton(
                    onPressed: () async {
                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      // final userPref = _pref.getString('userid');
                      final devicePref = _pref.getString('D_id');

                      if (newUser == true) {
                        await EasyLoading.showInfo(
                            'You Are New User \nYou Need to Take Survey');
                      } else if (devicePref != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompletedTaskPage()));
                      } else {
                        await EasyLoading.showInfo(
                            'Device ID Must Generate\n Connect Internet and restart the app');
                        // setState(() {
                        //  deviceId();
                        // });
                      }
                    },
                    height: 50,
                    minWidth: 250,
                    textColor: Colors.white,
                    child: Text(
                      "Completed Survey",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future dioPost() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final get_device_id = _pref.getString('D_id');
    if (get_device_id != null) {
      print("Device is Id Already..!\n Device Id $get_device_id");
    } else {
      if (connectivityCheck.isOnline != null) {
        if (connectivityCheck.isOnline) {
          var response = await _dio.post(
              'http://13.232.140.106:3030/rsi-field-force-api/user/send-deviceId');
          if (response.statusCode == 200) {
            print(response.data);
            String d = response.data['device_id'][0]['device_id'];
            deviceID = d;
            print("Device Id is : ${deviceID.toString()}");

            _pref.setString('D_id', deviceID);
            newUser = true;
          }
        } else {
          await EasyLoading.showInfo(
              'DeviceID Not Generated\n Need Internet Connection...! ');
        }
      }
      ;
    }
  }
}
