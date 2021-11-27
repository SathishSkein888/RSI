import 'dart:io';
import 'package:confetti/confetti.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_survey/components/connectivity_provider.dart';
import 'package:socio_survey/components/dbHelper.dart';
import 'package:socio_survey/components/no_internet.dart';

import 'data_view_screen.dart';

class FinalPage extends StatefulWidget {
  FinalPage({Key key}) : super(key: key);

  @override
  FinalPageState createState() => FinalPageState();
}

class FinalPageState extends State<FinalPage> {
  List listDatas = [];
  List<List<String>> finalListy = [];
  ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    // setState(() {
    //   fetchAndSetExcel();
    //   //print(listDatas);
    // });
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Image.asset('assets/images/complete.png'),
            SizedBox(
              height: 25,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(60.0),
            //     color: Color(0xfff89d4cf),
            //   ),
            //   child: FlatButton(
            //     onPressed: () async {
            //       setState(() {
            //         _isLoading = true;
            //       });
            //       // await listToCsv();
            //       Navigator.pushNamed(context, '/loadDataScreen');
            //       setState(() {
            //         _isLoading = false;
            //       });
            //     },
            //     height: 35,
            //     minWidth: 200,
            //     child: _isLoading
            //         ? Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 "Loading..",
            //                 style: GoogleFonts.quicksand(
            //                     color: Colors.white,
            //                     fontSize: 18.0),
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               CircularProgressIndicator(
            //                 color: Colors.white,
            //               )
            //             ],
            //           )
            //         : Text("Next",
            //             style: GoogleFonts.quicksand(
            //                 color: Colors.white, fontSize: 22.0)),
            //   ),
            // ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Color(0xfff445A63),
              ),
              child: FlatButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    int id = pref.getInt('userid');
                    int surveyId = id + 1;
                    pref.setInt('userid', surveyId);
                    pref.remove('page');
                    pref.remove('city');
                    Navigator.pushNamed(context, '/');
                  },
                  height: 35,
                  minWidth: 200,
                  child: Text("Home",
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontSize: 22.0))),
            )
          ],
        ),
      )),
    );
  }

  // fetchAndSetExcel() async {
  //   var dataList = await DbHelper.instance.userMapList();
  //   dataList.forEach((element) {
  //     listDatas.add(element);
  //     print(listDatas);
  //   });
  // }

  // listToCsv() async {
  //   fetchAndSetExcel();
  //   List<List<String>> modify = [];

  //   Set<List<String>> set = Set.from(listDatas);
  //   set.forEach((element) {
  //     modify.add(element);
  //   });
  //   print('---->$modify');
  //   String csvData = ListToCsvConverter().convert(modify);
  //   final String directory = (await getExternalStorageDirectory()).path;
  //   final path = "$directory/all-data-csv-${DateTime.now()}.csv";
  //   print(path);
  //   final File file = File(path);
  //   await file.writeAsString(csvData);
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return LoadDataScreen(path: path);
  //       },
  //     ),
  //   );
  // }
}
