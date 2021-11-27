// import 'dart:convert';
// import 'dart:io';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socio_survey/components/connectivity_provider.dart';
// import 'package:socio_survey/components/dbHelper.dart';
// import 'package:socio_survey/components/dbModel.dart';

// class LoadDataScreen extends StatefulWidget {
//   final String path;

//   LoadDataScreen({this.path});

//   @override
//   _LoadDataScreenState createState() => _LoadDataScreenState();
// }

// class _LoadDataScreenState extends State<LoadDataScreen> {
//   List<DbModel> _list;
// //  List<dynamic> _list;
//   // var dbmodel = DbModel();
//   var csvList = [];

//   @override
//   void initState() {
//     // Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
//     fetchFromDB();
//     super.initState();
//   }

//   // getAllDatas() async {
//   //   var dbList = DbHelper.instance.getData();
//   // }
//   // fetchAndSetExcel() async {
//   //   var dataList = await DbHelper.instance.userMapList();
//   //   dataList.forEach((element) {
//   //     listDatas.add(element);
//   //     print(listDatas);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text("User Entered"),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: InkWell(
//                   onTap: () async {
//                     await listToCsv();
//                   },
//                   child: Icon(Icons.download)),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: ListView.builder(
//               itemCount: _list.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   // crossAxisAlignment: CrossAxisAlignment.center,

//                   children: [
//                     index == 0
//                         ? Row(
//                             //mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     "Id",
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 20,
//                                     ),
//                                   )),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     "Question",
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 20,
//                                     ),
//                                   )),
//                               Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "Answer",
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 20,
//                                     ),
//                                   )),
//                             ],
//                           )
//                         : SizedBox(),
//                     index == 0
//                         ? SizedBox(
//                             height: 20,
//                           )
//                         : SizedBox(),
//                     Divider(
//                       thickness: 0.5,
//                       color: Colors.grey.shade400,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                             flex: 1,
//                             child: Text(_list[index].surveyId.toString())),
//                         Expanded(
//                             flex: 3,
//                             child: Text(_list[index].question.toString(),
//                                 style: _list[index].question ==
//                                             "USER DETAILS" ||
//                                         _list[index].question ==
//                                             "HOUSEHOLD PROFILE" ||
//                                         _list[index].question == "HOUSING" ||
//                                         _list[index].question ==
//                                             "ECONOMY & INDUSTRIES" ||
//                                         _list[index].question ==
//                                             "TRANSPORTATION" ||
//                                         _list[index].question ==
//                                             "PHYSICAL INFRASTRUCTURE" ||
//                                         _list[index].question ==
//                                             "SOCIAL INFRASTRUCTURE" ||
//                                         _list[index].question == "SLUMS" ||
//                                         _list[index].question == "COASTAL" ||
//                                         _list[index].question ==
//                                             "ENVIRONMENT RELATED" ||
//                                         _list[index].question ==
//                                             "CUTURAL AND HERITAGE" ||
//                                         _list[index].question == "TOURISM"
//                                     ? TextStyle(fontWeight: FontWeight.bold)
//                                     : TextStyle())),
//                         Expanded(
//                             flex: 2,
//                             child: Text(_list[index].answer.toString())),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     )
//                   ],
//                 );
//               }),
//         ));
//   }

//   fetchFromDB() async {
//     _list = [];
//     var dataList = await DbHelper.instance.userMapList();
//     dataList.forEach((element) {
//       setState(() {
//         var dbmodel = DbModel();
//         dbmodel.id = element['id'];
//         dbmodel.surveyId = element['surveyId'];
//         dbmodel.question = element['question'];
//         dbmodel.answer = element['answer'];
//         _list.add(dbmodel);
//       });
//     });
//   }

//   listToCsv() async {
//     _list.forEach((element) {
//       csvList.add(element);
//       print(csvList);
//     });

//     //List<List<dynamic>> intList = csvList.cast<List<dynamic>>();
//     String csvData = ListToCsvConverter().convert(csvList);
//     final String directory = (await getExternalStorageDirectory()).path;
//     final path = "$directory/all-data-csv-${DateTime.now()}.csv";
//     print(path);
//     final File file = File(path);
//     await file.writeAsString(csvData);
//   }
// }
