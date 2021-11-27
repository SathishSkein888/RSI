import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TablePage extends StatefulWidget {
  TablePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();

  // List rows = [
  //   {"gender": '-', "typeOfSchool": '-', "dropout": '-', "reason": '-'},
  //   {"gender": '-', "typeOfSchool": '-', "dropout": '-', "reason": '-'},
  //   {"gender": '-', "typeOfSchool": '-', "dropout": '-', "reason": '-'},
  //   {"gender": '-', "typeOfSchool": '-', "dropout": '-', "reason": '-'},
  // ];
  List rows = [];
  List cols = [
    {"title": 'Boy/Girl', 'key': 'gender'},
    {"title": 'Type of School', 'key': 'typeOfSchool'},
    {"title": 'Age of dropout', 'key': 'dropout'},
    {"title": 'Reason', 'key': 'reason'},
  ];

  /// Function to add a new row
  /// Using the global key assigined to Editable widget
  /// Access the current state of Editable
  void _addNewRow() {
    setState(() {
      _editableKey.currentState.createRow();
    });
  }

  ///Print only edited rows.
  void _printEditedRows() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    String checkExist = _preference.getString('table');
    if (checkExist != null) {
      _preference.remove('table');
    }
    List editedRows = _editableKey.currentState.editedRows;

    //print(editedRows);
    String finalRow = editedRows.join("");
    _preference.setString('table', finalRow);
    print(finalRow);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xfff89d4cf),
        title: Text("Add Students"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => _printEditedRows(),
              icon: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: Center(
        child: Editable(
          key: _editableKey,
          columns: cols,
          rows: rows,
          //zebraStripe: true,
          // stripeColor1: Colors.blue[50],
          //stripeColor2: Colors.grey[200],
          onRowSaved: (value) {
            print(value);
          },
          onSubmitted: (value) {
            print(value);
          },
          //borderColor: Color(0xfff89d4cf),
          // tdStyle: TextStyle(fontWeight: FontWeight.),
          trHeight: 80,
          thStyle: TextStyle(fontSize: 15),
          thAlignment: TextAlign.center,
          thVertAlignment: CrossAxisAlignment.end,
          thPaddingBottom: 3,
          //showSaveIcon: true,
          //saveIconColor: Colors.black,
          showCreateButton: true,
          tdAlignment: TextAlign.left,
          tdEditableMaxLines: 100, // don't limit and allow data to wrap
          tdPaddingTop: 0,
          tdPaddingBottom: 14,
          tdPaddingLeft: 10,
          tdPaddingRight: 8,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(0))),
        ),
      ),
    );
  }
}

