import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:async';
import 'dbModel.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._instance();
  static Database _db = null;
  DbHelper._instance();

  String id = 'id';
  String surveyId = 'survey_id';
  String question = 'question';
  String answer = 'answer';
  String city = 'city';

  String table = 'socio';
  String dbname = 'socio.db';

  Directory documentDirectory;
  String path;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    documentDirectory = await getApplicationDocumentsDirectory();
    path = join(documentDirectory.path, dbname);
    final db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY AUTOINCREMENT ,$surveyId TEXT,$city TEXT ,$question TEXT ,$answer TEXT )');
  }

  Future<List<Map<String, dynamic>>> userMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(table);
    return result;
  }
  // userMapList() async {
  //   Database? db = await this.db;
  //   //final List<Map<String, dynamic>> result = await db!.query(table);
  //   return await db!.query(table);
  // }

  Future<List<DbModel>> getData() async {
    final List<Map<String, dynamic>> physicalMapList = await userMapList();
    final List<DbModel> houselist = [];
    physicalMapList.forEach((element) {
      houselist.add(DbModel.fromMap(element));
    });
    print(houselist);
    return houselist;
  }

  Future<int> insertData({surveyId, question, answer, city}) async {
    Database db = await this.db;
    final int result = await db.rawInsert(
        'INSERT INTO $table(survey_id,city,question, answer) VALUES(?, ?,?,?)',
        [surveyId, city, question, answer]);
    print(result);
    return result;
  }

  Future<int> updateData(DbModel userDetailsDb) async {
    Database db = await this.db;
    final int result = await db.update(table, userDetailsDb.toMap(),
        where: '$id=?', whereArgs: [userDetailsDb.id]);
    return result;
  }

  Future<int> deleteData() async {
    Database db = await this.db;
    final int result = await db.delete(table);
    return result;
  }

  // Future<int> deleteData(DbModel userDetailsDb) async {
  //   Database db = await this.db;
  //   final int result = await db.delete(table, where: '$id=?', whereArgs: [id]);
  //   return result;
  // }

  // Future<String> exportSingleTable() async {
  //   // var dbPath;
  //   var dir;
  //   var excludes = [];
  //   var prettify = new Map<dynamic, dynamic>();
  //   var finalpath = "";

  //   // Exclude column(s) from being exported
  //   excludes.add("id");

  //   // Prettifies columns name
  //   prettify["question"] = "Question";
  //   prettify["answer"] = "Answer";

  //   // Table name that will be exported
  //   //var tableName = "customer";

  //   //final directory = await getExternalStorageDirectory();
  //   //var path = directory.path;
  //   //path = directory.path;
  //   //path = join(path, dbname);
  //   //documentDirectory = path + "/";

  //   //final directory = await getExternalStorageDirectory();
  //   //var path = directory.path;
  //   path = documentDirectory.path;
  //   path = join(documentDirectory.path, dbname);

  //   dir = path + "/";

  //   try {
  //     finalpath = await Sqlitetoexcel.exportSingleTable(path, "documents", "",
  //         "ExportSingleTable.xls", table, excludes, prettify);
  //   } on PlatformException catch (e) {
  //     print(e.message.toString());
  //   }
  //   return finalpath;
  // }
}
