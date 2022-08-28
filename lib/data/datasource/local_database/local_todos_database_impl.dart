import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/datasource/remote_database/dio/dio_client.dart';
import 'package:todoapp/domain/mapper/mapper.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';

import '../../../core/constants/strings.dart';
import '../remote_database/remote_todos_database_impl.dart';
import '../todos_database.dart';
import 'database_helper.dart';

class LocalTodosDatabaseImpl implements TodosDatabase {
  var databaseFuture = DatabaseHelper.db.database;
  final RemoteTodosDatabaseImpl remoteTodos =
      RemoteTodosDatabaseImpl(dioClient: DioClient());

  @override
  Future<TodoList> allTodos() async {
    TodoList currantTodos;
    final Database database = await databaseFuture;
    final todoMap = await database.query(S.sqflite.databaseName);
    final List<Todo> todoList = List<Todo>.from(
      todoMap.map((todo) => TodoMapper().transformToModel(todo)),
    );
    Map<String, dynamic> todoObject = TodoMapper().transformListToMap(todoList);
    currantTodos = TodoMapper().transformListToModel(todoObject);
    return currantTodos;
  }

  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    late final Todo todoEntity;
    await database.transaction(
      (txn) async {
        final id = await txn.insert(
          S.sqflite.databaseName,
          TodoMapper().transformToMap(todo),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        final results = await txn.query(
          S.sqflite.databaseName,
          where: '${DatabaseHelper.columnAutoId} = ?',
          whereArgs: [id],
        );
        todoEntity = TodoMapper().transformToModel(results.first);
      },
    );
    return todoEntity;
  }

  @override
  Future<void> updateTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    final String id = todo.id;
    await database.update(
      S.sqflite.databaseName,
      TodoMapper().transformToMap(todo),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    final Database database = await databaseFuture;
    await database.delete(
      S.sqflite.databaseName,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) async {
    return todoList;
  }
}
