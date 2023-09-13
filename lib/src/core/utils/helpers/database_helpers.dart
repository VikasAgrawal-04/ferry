import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/your_pass/your_passes_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.init();
  static Database? database;
  static Directory? dir;
  DatabaseHelper.init();

  Future<Database> get fetchDatabase async {
    if (database != null) return database!;
    database = await _initDB('ferry.db');
    return database!;
  }

  bool get isDatabaseInitialized => database != null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    dir = await getApplicationDocumentsDirectory();
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Passes (
        id INTEGER PRIMARY KEY,
        passid INTEGER,
        routeid INTEGER,
        userid INTEGER,
        buy_date TEXT,
        buy_time TEXT,
        cost TEXT,
        valid_till_date TEXT,
        payment_mode TEXT,
        payment_reference TEXT,
        is_active TEXT,
        is_deleted TEXT,
        currentuserid INTEGER,
        currentdeviceid TEXT,
        is_under_transfer TEXT,
        passcode TEXT,
        passname TEXT,
        vehicletype TEXT,
        passdays INTEGER,
        routename TEXT,
        routeimg TEXT
      )
    ''');
  }

  Future<void> insertPasses(List<YourPassDatum> data) async {
    if (data.isNotEmpty) {
      for (final single in data) {
        final rawData = single.toJson();
        rawData.remove('transfers');
        await database?.insert('Passes', rawData,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<List<YourPassDatum>> fetchPasses() async {
    final passes = <YourPassDatum>[];
    final list = await database?.query('Passes');
    if (list != null && list.isNotEmpty) {
      for (final single in list) {
        passes.add(YourPassDatum.fromJson(single));
      }
    }

    return passes;
  }

  Future<void> deletePass(int id) async {
    await database?.delete('Passes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase() async {
    await database?.delete('Passes');
  }
}
