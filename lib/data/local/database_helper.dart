import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../resources/constants/database_constant.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, DatabaseConstant.dbName),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE ${DatabaseConstant.utensilsTable} (
               id INTEGER PRIMARY KEY,
               name TEXT, isSelected INTEGER
             )''',
        );
      },
      version: 1,
    );

    return db;
  }


}