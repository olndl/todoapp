import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/datasource/database/todos_database.dart';

import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import '../network_service.dart';


class TodosDatabaseImpl implements TodosDatabase {

  final NetworkService networkService;

  TodosDatabaseImpl({required this.networkService});


  @override
  Future<TodoList> allTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw;
  }


  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final bodeRequest = {"status": "ok", "element": todo.toJson()};
     final newTodo = await networkService.addTodo(bodeRequest, revision);
     return newTodo;
  }


  @override
  Future<void> updateTodo(Todo todo, int revision) async {
     final bodyRequest = {"status": "ok", "element": todo.toJson()};
     await networkService.changeTodo(bodyRequest, todo.id, revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    await networkService.deleteTodo(id, revision);
  }

}

// static const _databaseName = 'todos_database';
// static const _tableName = 'todos_table';
// static const _databaseVersion = 1;
// static const _columnId = 'id';
// static const _columnCreatedAt = 'created_at';
// static const _columnTitle = 'title';
// static const _columnLastUpdatedBy = 'last_updated_by';
// static const _columnChangedAt = 'changed_at';
// static const _columnDueDate = 'deadline';
// static const _columnColor = 'color';
// static const _columnIsCompleted = 'done';
// static const _columnImportance = 'importance';
// static Database? _database;

// Future<Database> get database async {
//   _database ??= await _initDatabase();
//   return _database!;
// }

// Future<Database> _initDatabase() async {
//   return openDatabase(
//     join(await getDatabasesPath(), _databaseName),
//     onCreate: (db, _) {
//       db.execute('''
//         CREATE TABLE $_tableName(
//           $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
//           $_columnCreatedAt INTEGER NOT NULL
//           $_columnTitle TEXT NOT NULL
//           $_columnLastUpdatedBy TEXT NOT NULL
//           $_columnChangedAt INTEGER NOT NULL
//           $_columnDueDate INTEGER
//           $_columnColor TEXT
//           $_columnIsCompleted INTEGER NOT NULL
//           $_columnImportance TEXT NOT NULL
//         )
//       ''');
//     },
//     version: _databaseVersion,
//   );
// }