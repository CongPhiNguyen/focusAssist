import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  Future _onCreate(Database db, int version) {
    db.execute(
      '''
      CREATE TABLE USER(
        USERID TEXT PRIMARY KEY,
        USERNAME TEXT NOT NULL
       );
      '''
    );
  }

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> query(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
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