import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:socio_survey/main.dart';

import 'survey_id_model.dart';

class SubPage extends StatefulWidget {
  final String index;
  SubPage({Key key, this.index}) : super(key: key);

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  Future<SurveyIdModel> futureData;
  @override
  void initState() {
    futureData = getId(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff89d4cf),
          title: Text(
            "${widget.index} Data",
            style: GoogleFonts.quicksand(
                fontSize: 22, fontWeight: FontWeight.bold),
          )),
      body: FutureBuilder<SurveyIdModel>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, index) {
                  final userData = snapshot.data.data;
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        index == 0
                            ? Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //     flex: 1,
                                  //     child: Text(
                                  //       "Id",
                                  //       style: GoogleFonts.quicksand(
                                  //         fontSize: 20,
                                  //       ),
                                  //     )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Question",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Value",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                        ),
                                      )),
                                ],
                              )
                            : SizedBox(),
                        index == 0
                            ? SizedBox(
                                height: 20,
                              )
                            : SizedBox(),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Expanded(
                            //     flex: 1, child: Text(userData[index].question.toString())),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  userData[index].question.toString(),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(userData[index].answer.toString())),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }

  Future<SurveyIdModel> getId(id) async {
    final response = await http.get(Uri.parse(
        'http://13.232.140.106:3030/rsi-field-force-api/user/get-survey-details?survey_id=$id'));
    if (response.statusCode == 200) {
      print("Response===${response.body}");
      return SurveyIdModel.fromJson(jsonDecode(response.body));
      // var items = jsonDecode(response.body);
      // users = items;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
