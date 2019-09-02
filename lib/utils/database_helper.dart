import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:naragireg/models/visitors.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String visitorsTable = 'tblVisitors';
  String colId = "id";
  String colname = "name";
  String colPhone = "phonenumber";
  String colAdress = "address";
  String colPurpose = "purpose";
  String colTagno = "tagno";
  String coldatein = "datein";
  String colTimein = "timein";
  String colTimeout = "timeout";
  String coldateout = "dateout";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'visitorsdbase.db';
    var visitorsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return visitorsDatabase;
  }

  void _createDb(Database db, int newversion) async {
    await db.execute(
        'CREATE TABLE $visitorsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, $colPhone TEXT, $colAdress TEXT, $colPurpose TEXT, $colTagno TEXT, $coldatein TEXT, $colTimein TEXT,$coldateout TEXT, $colTimeout TEXT)');
  }

  Future<List<Map<String, dynamic>>> getVisitorsMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $visitorsTable order by $colId DESC');
    //var result = await db.query(visitorsTable, orderBy: '$colId DESC' );
    return result;
  }

  Future<List<Map<String, dynamic>>> getTodayVisitorsMapList(String str) async {
    Database db = await this.database;
   // var result =        await db.rawQuery('SELECT * FROM $visitorsTable order by $colId DESC');
    var result = await db.query(visitorsTable, where: '$coldatein =?',whereArgs: [str], orderBy: '$colId DESC' );
    return result;
  }

  Future<int> insertVisitor(VisitorsObj visitors) async {
    Database db = await this.database;
    var result = await db.insert(visitorsTable, visitors.toMap());

    return result;
  }

  Future<int> updateVisitor(VisitorsObj visitors) async {
    Database db = await this.database;
    var result = await db.update(visitorsTable, visitors.toMap(),
        where: '$colId = ?', whereArgs: [visitors.id]);

    return result;
  }

  Future<int> deleteVisitor(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $visitorsTable WHERE $colId = $id');

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $visitorsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<VisitorsObj>> getVisitorsList() async {
    var visitorsMapList = await getVisitorsMapList();
    int count = visitorsMapList.length;

    List<VisitorsObj> visitorsList = List<VisitorsObj>();

    for (int i = 0; i < count; i++) {
      visitorsList.add(VisitorsObj.fromMapObject(visitorsMapList[i]));
    }

    return visitorsList;
  }

    Future<List<VisitorsObj>> getTodayVisitorsList(String str) async {
    var visitorsMapList = await getTodayVisitorsMapList(str);
    int count = visitorsMapList.length;

    List<VisitorsObj> visitorsList = List<VisitorsObj>();

    for (int i = 0; i < count; i++) {
      visitorsList.add(VisitorsObj.fromMapObject(visitorsMapList[i]));
    }

    return visitorsList;
  }

}
