import 'dart:io';

import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:intl/intl.dart';
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
    await db.execute('''
      CREATE TABLE  IF NOT EXISTS Transfers (
        transferid INTEGER PRIMARY KEY,
        passid INTEGER,
        transferstartdatetime TEXT,
        fromuserid INTEGER,
        fromdeviceid TEXT,
        is_transfer_completed TEXT,
        transfercompleted_datetime TEXT,
        received_userid INTEGER,
        received_deviceid TEXT,
        isdeleted TEXT,
        transfercode TEXT,
        passcode TEXT
      )
    ''');
  }

  Future<void> insertPasses(List<YourPassDatum> data) async {
    try {
      print("insertion ${data.length}");
      if (data.isNotEmpty) {
        for (final single in data) {
          final rawData = single.toJson();
          final trasnfers = single.transfers;
          print("Insertions in transfers $trasnfers");
          if (trasnfers != null && trasnfers.isNotEmpty) {
            for (final transfer in trasnfers) {
              print("Inserted INserted");
              print(transfer.toJson());
              await database?.insert('Transfers', transfer.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
              print("Data Inserted ${await database?.query('Transfers')}");
            }
          }
          rawData.remove('transfers');
          await database?.insert('Passes', rawData,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    } catch (error) {
      Helpers.logger(type: LoggerType.e, message: error.toString());
    }
  }

  Future<List<YourPassDatum>> fetchPasses() async {
    final passes = <YourPassDatum>[];
    final today = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');

    await database?.transaction((txn) async {
      final list = await txn.query('Passes');
      if (list.isNotEmpty) {
        for (final single in list) {
          final rawData = Map<String, dynamic>.from(single);
          final validTillDateStr = rawData['valid_till_date'];
          final passcode = rawData['passcode'];

          // Parse the valid_till_date
          final validTillDate = formatter.parse(validTillDateStr);
          // Check if today is after the valid_till_date
          if (today.isAfter(validTillDate)) {
            // Delete the pass
            await txn
                .delete('Passes', where: 'passcode = ?', whereArgs: [passcode]);

            // Delete associated transfers
            await txn.delete('Transfers',
                where: 'passcode = ?', whereArgs: [passcode]);
            continue;
          }

          // Fetching the transfers
          final transfers = await txn
              .query('Transfers', where: 'passcode = ?', whereArgs: [passcode]);
          if (transfers.isNotEmpty) {
            rawData['transfers'] = transfers;
          }
          passes.add(YourPassDatum.fromJson(rawData));
        }
      }
    });

    return passes;
  }

  Future<void> deletePass(int id) async {
    await database?.delete('Passes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deletePasses() async {
    await database?.delete('Passes');
  }

  Future<void> deleteEverything() async {
    await database?.delete('Passes');
    await database?.delete('Transfers');
  }
}
