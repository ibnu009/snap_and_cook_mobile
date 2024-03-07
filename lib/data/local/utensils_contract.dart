import 'package:snap_and_cook_mobile/data/remote/models/utensil_model.dart';
import 'package:snap_and_cook_mobile/utils/extension/database_extension.dart';
import 'package:sqflite/sqflite.dart';

import '../../resources/constants/database_constant.dart';
import 'database_helper.dart';

class UtensilContract {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertUtensil(Utensil utensil) async {
    final Database db = await _databaseHelper.database;
    await db.insert(DatabaseConstant.utensilsTable, utensil.toJson());
    print('Data saved!');
  }

  Future<void> insertAllUtensil(List<Utensil> utensil) async {
    final Database db = await _databaseHelper.database;
    await db.insertMultiple(
        DatabaseConstant.utensilsTable, utensil.map((e) => e.toJson()),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    print('All Data saved!');
  }

  Future<void> updateUtensil(Utensil utensil) async {
    final Database db = await _databaseHelper.database;
    await db.update(DatabaseConstant.utensilsTable, utensil.toJson(),
        where: 'id = ?', whereArgs: [utensil.id]);
    print('Data changed!');
  }

  Future<List<Utensil>> getUtensils() async {
    final Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> results =
        await db.query(DatabaseConstant.utensilsTable);
    return results.map((res) => Utensil.fromJson(res)).toList();
  }

  Future<List<String>> getSelectedUtensils() async {
    final Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> results =
    await db.query(DatabaseConstant.utensilsTable,where: 'isSelected = 1');
    return results.map((res) => Utensil.fromJson(res).name ?? '').toList();
  }
}
