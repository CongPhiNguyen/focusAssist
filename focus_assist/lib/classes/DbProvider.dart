import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;



class DbProvider {
  static final dbName = 'myDatabase.db';
  static final dbVersion = 1;

  DbProvider._privateConstructor();
  static final DbProvider instance = DbProvider._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('onCreate');
    String script = await rootBundle.loadString(
        'assets/Database/create_tables_script.sql');
    print('LoadString');
    List<String> scripts = script.split(";");
    scripts.forEach((element) {
      if (element.isNotEmpty) {
        print(element.trim());
        db.execute(element.trim());
      }
    });
  }

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> query(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> sreach(String tableName, String taiKhoan) async {
    Database db = await instance.database;
    return await db.query(tableName,where: 'TENTAIKHOAN == $taiKhoan');
  }

  Future<int> update(String tableName, Map<String, dynamic> row, String key, String arg) async {
    Database db = await instance.database;
    return await db.update(tableName, row, where:'$key = ?', whereArgs: [arg]);
  }

  Future<int> delete(String tableName, String key, String arg) async {
    Database db = await instance.database;
    return await db.delete(tableName, where:'$key = ?', whereArgs: [arg]);
  }


}