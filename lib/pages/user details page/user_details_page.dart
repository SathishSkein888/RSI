import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/dbHelper/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';
import 'package:socio_survey/components/textfield_container.dart';
import 'package:socio_survey/components/userFields.dart';
import 'package:socio_survey/pages/householdprofilepage/household_profile_page.dart';
import 'package:socio_survey/pages/housing%20page/housing_page.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/pages/user%20details%20page/userPost.dart';
import 'package:socio_survey/pages/user%20details%20page/userdetails_api.dart';
import 'package:native_state/native_state.dart';

class UserDetails extends StatefulWidget {
  static const String route = "/user_details";
  // final SavedStateData savedState;
  // final bool restoredFromState;
  // UserDetails({this.savedState})
  //     : this.restoredFromState = savedState.getBool("saved") {
  //   savedState.putBool("saved", true);
  // }

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  static TextEditingController _localityController = TextEditingController();
  static TextEditingController _wardController = TextEditingController();
  static TextEditingController _totalMemberController = TextEditingController();
  static TextEditingController _familyHeadNameController =
      TextEditingController();
  static TextEditingController _maleController = TextEditingController();
  static TextEditingController _femaleController = TextEditingController();
  static TextEditingController _illiterateMemberController =
      TextEditingController();
  static TextEditingController _casteController = TextEditingController();
  static TextEditingController _religionController = TextEditingController();
  static TextEditingController _minorityStatusController =
      TextEditingController();
  static TextEditingController _mobileNumberController =
      TextEditingController();

  bool _isLoading = false;
  Connectivity _connectivity = new Connectivity();

  bool _isOnline;
  // Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  // var deviceId;
  // var userId;
  @override
  void initState() {
    startMonitoring();
    //Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    page();
    super.initState();
    // deviceId = _preferences.then((value) => value.getString('deviceid'));
    // userId = _preferences.then((value) => value.getString('userid'));
  }

  // Future getDeviceId() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final id = preferences.getString('deviceid');
  //  // deviceID = id;
  // }

  //String deviceID = '';
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String title = 'User Details';

  Future page() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("page", "/user_details");
  }

  Future pageData() async {
    SharedPreferences preferencesPage = await SharedPreferences.getInstance();
    preferencesPage.setStringList('pageData', prefList);
  }

  List prefList = [];
  //var prefList =  List[];
  // @override
  // void dispose() {
  //   _localityController.dispose();
  //   _wardController.dispose();
  //   _totalMemberController.dispose();
  //   _familyHeadNameController.dispose();
  //   _maleController.dispose();
  //   _femaleController.dispose();
  //   _illiterateMemberController.dispose();
  //   _casteController.dispose();
  //   _religionController.dispose();
  //   _minorityStatusController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RSI FieldForce",
                                style: GoogleFonts.quicksand(
                                    fontSize: 55.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                                // style: TextStyle(
                                //     fontSize: 46.0,
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "User Details",
                                style: GoogleFonts.quicksand(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Mobile Number',
                                      textController: _mobileNumberController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldContainer(
                                      labelText: 'Name of Locality',
                                      textController: _localityController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Ward',
                                      textController: _wardController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Members',
                                      textController: _totalMemberController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldContainer(
                                      labelText: 'Full Name of family head',
                                      textController: _familyHeadNameController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Males',
                                      textController: _maleController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText: 'Total No of Females',
                                      textController: _femaleController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NumberTextFieldContainer(
                                      labelText:
                                          'Total No of Illiterate Members',
                                      textController:
                                          _illiterateMemberController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldContainer(
                                      labelText: 'Caste',
                                      textController: _casteController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldContainer(
                                      labelText: 'Religion',
                                      textController: _religionController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldContainer(
                                      labelText: 'Minority Status',
                                      textController: _minorityStatusController,
                                      onChange: (value) {
                                        prefList.add(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xff8E2DE2),
                                      ),
                                      child: FlatButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();

                                            Map<String, String> userData =
                                                Map();
                                            userData['USER DETAILS'] = '';
                                            userData['Name of Locality'] =
                                                _localityController.text;
                                            userData['Ward'] =
                                                _wardController.text;
                                            userData['Total No of Member'] =
                                                _totalMemberController.text;
                                            userData[
                                                    'Full Name of family head'] =
                                                _familyHeadNameController.text;
                                            userData['Male'] =
                                                _maleController.text;
                                            userData['Female'] =
                                                _femaleController.text;
                                            userData['Illiterate Member'] =
                                                _illiterateMemberController
                                                    .text;
                                            userData['Caste'] =
                                                _casteController.text;
                                            userData['Religion'] =
                                                _religionController.text;
                                            userData['Minority Status'] =
                                                _minorityStatusController.text;

                                            if (_isOnline != null) {
                                              if (_isOnline) {
                                                await passData();
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                print("Go from Server");
                                                await Navigator.pushNamed(
                                                    context,
                                                    '/household_profile');
                                              } else {
                                                final sId = preferences
                                                    .getString("survey_id");
                                                final city = preferences
                                                    .getString("city");
                                                userData.forEach(
                                                    (key, value) async {
                                                  await DbHelper.instance
                                                      .insertData(
                                                          answer: value,
                                                          city: city,
                                                          surveyId: sId,
                                                          question: key);
                                                });
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                print("Go from local Db");
                                                await Navigator.pushNamed(
                                                    context,
                                                    '/household_profile');
                                              }
                                            }
                                            await Navigator.pushNamed(
                                                context, '/household_profile');
                                          } else {
                                            showSnackBar();
                                          }
                                        },
                                        height: 50,
                                        minWidth: 250,
                                        textColor: Colors.white,
                                        child: _isLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Loading..",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 18.0),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                ],
                                              )
                                            : Text("Take Survey",
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 22.0)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((
      ConnectivityResult result,
    ) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        // notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          // notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        _isOnline = false;
        // notifyListeners();
      } else {
        _isOnline = true;
        // notifyListeners();
      }
    } on PlatformException catch (e) {
      print("PlatformException: " + e.toString());
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      //return false;
    }
    return isConnected;
  }

  Future passData() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final deviceId = _preferences.getString('D_id');
    final surveyId =
        _preferences.getString('survey_id') ?? '${deviceId.toString()}' + 'S1';
    final cityPref = _preferences.getString('city');

    // List<String> listPref = <String>[];
    // _preferences.setStringList('list', listPref);
    List<UserPost> userPost = [
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Mobile Number",
          answer: _mobileNumberController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Name of Locality",
          answer: _localityController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Ward",
          answer: _wardController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Total No of Member",
          answer: _totalMemberController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Full Name of family head",
          answer: _familyHeadNameController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Male",
          answer: _maleController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Female",
          answer: _femaleController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Illiterate Member",
          answer: _illiterateMemberController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Caste",
          answer: _casteController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Religion",
          answer: _religionController.text),
      UserPost(
          city: cityPref,
          surveyId: surveyId,
          deviceId: deviceId,
          question: "Minority Status",
          answer: _minorityStatusController.text),
    ];
    // listPref.add(userPost);
    userPost.forEach((e) async {
      await postMethod(
          deviceId: e.deviceId,
          city: e.city,
          surveyId: e.surveyId,
          ques: e.question,
          ans: e.answer);
      // listPref.add(e);
    });
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

  // Future saveList() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final String encodedData = UserDetailsApi.encode([
  //     UserDetailsApi(
  //         localityName: _localityController.text,
  //         ward: _wardController.text,
  //         totalNoOfMembers: _totalMemberController.text,
  //         familyHeadFullname: _familyHeadNameController.text,
  //         male: _maleController.text,
  //         female: _femaleController.text,
  //         illetrateMember: _illiterateMemberController.text,
  //         caste: _casteController.text,
  //         religion: _religionController.text,
  //         minorityStatus: _minorityStatusController.text),
  //   ]);

  //   await sharedPreferences.setString('userlist', encodedData);
  // }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'All fields are mandatory .*',
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

  // sendUserProfile() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://10.0.2.2:3000/socio-economic-survey-api/user/family-details'),
  //         // headers: <String, String>{
  //         //   'Content-Type': 'application/json; charset=UTF-8',
  //         // },
  //         body: {
  //           'locality_name': _localityController.text,
  //           'ward': _wardController.text,
  //           'total_no_of_members': _totalMemberController.text,
  //           'family_head_fullname': _familyHeadNameController.text,
  //           'male': _maleController.text,
  //           'female': _femaleController.text,
  //           'illetrate_member': _illiterateMemberController.text,
  //           'caste': _casteController.text,
  //           'religion': _religionController.text,
  //           'minority_status': _minorityStatusController.text,
  //         });
  //     // print(response.body);
  //     String id = response.body;
  //     print(id);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  generateCsv() async {
    List<List<String>> data = [
      ["User details"],
      ["QUESTION", "SELECTED"],
      ["Name of Locality", _localityController.text],
      ["Ward", _wardController.text],
      ["Total No of Member", _totalMemberController.text],
      ["Full Name of family head", _familyHeadNameController.text],
      ["Male", _maleController.text],
      ["Female", _femaleController.text],
      ["Illiterate Member", _illiterateMemberController.text],
      ["Caste", _casteController.text],
      ["Religion", _religionController.text],
      ["Minority Status", _minorityStatusController.text],
    ];
    String csvData = ListToCsvConverter().convert(data);
    final String directory = (await getExternalStorageDirectory()).path;
    final path = "$directory/user-details-csv-${DateTime.now()}.csv";
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return LoadCsvDataScreen(path: path);
    //     },
    //   ),
    // );
  }
}
