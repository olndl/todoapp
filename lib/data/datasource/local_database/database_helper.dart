import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/strings.dart';

class DatabaseHelper {
  static const tableName = 'todos_table';
  static const databaseVersion = 1;
  static const columnId = 'id';
  static const columnCreatedAt = 'created_at';
  static const columnText = 'text';
  static const columnLastUpdatedBy = 'last_updated_by';
  static const columnChangeAt = 'changed_at';
  static const columnColor = 'color';
  static const columnDone= 'done';
  static const columnDeadline = 'deadline';
  static const columnImportance = 'importance';

  DatabaseHelper._instance();

  static final DatabaseHelper db = DatabaseHelper._instance();
  late Database _database;

  Future<Database> get database async {
    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = directory.path + S.DATABASE_NAME;

    var db = await openDatabase(databasePath, version: databaseVersion, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $tableName(
            $columnId STRING NOT NULL,
            $columnCreatedAt INTEGER NOT NULL,
            $columnText TEXT NOT NULL,
            $columnLastUpdatedBy TEXT NOT NULL,
            $columnChangeAt INTEGER NOT NULL,
            $columnColor TEXT,
            $columnDone INTEGER NOT NULL,  
            $columnDeadline INTEGER
            $columnImportance TEXT NOT NULL
          )
        ''');
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}