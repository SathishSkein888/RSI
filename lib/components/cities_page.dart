import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cities extends StatefulWidget {
  Cities({Key key}) : super(key: key);

  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  String valueChoose;
  SharedPreferences sharedPreferences;

  List cities = [
    "HOWRAH MUNICIPAL CORPORATION",
    "RAJPUR-SONARPUR",
    "MAHESHTALA",
    "SANTIPUR",
    "BALURGHAT",
    "SILIGURI MUNICIPAL CORPORATION",
    "JALPAIGURI",
    "DARJEELING"
  ];
  Future cityPref(String city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("city", city);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xfff6e45e1), Color(0xfff89d4cf)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Container(
        margin: EdgeInsets.only(top: 150, bottom: 150, left: 15, right: 15),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AMRUT CITIES IN WEST BENGAL",
              style: GoogleFonts.quicksand(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton(
                  hint: Text("Select Cities"),
                  value: valueChoose,
                  onChanged: (value) {
                    setState(() {
                      valueChoose = value;
                      cityPref(valueChoose);
                    });
                    // setState(() {
                    //   valueChoose = value;
                    //   print(valueChoose);
                    // });
                  },
                  items: cities.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList()),
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
                    if (valueChoose != null) {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      var printValue = preferences.getString("city");
                      print(
                          "Choosen Value Strored in sharedPreferences is =$printValue");
                      Navigator.pushNamed(context, "/user_details");
                    } else {
                      await EasyLoading.showInfo("Please Select City");
                    }
                  },
                  height: 50,
                  minWidth: 250,
                  textColor: Colors.white,
                  child: Text("Next",
                      style: GoogleFonts.quicksand(fontSize: 22.0))),
            ),
          ],
        ),
      ),
    );
  }
}
