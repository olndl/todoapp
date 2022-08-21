
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/strings.dart';
import '../../../domain/model/todo_list.dart';
import 'db.dart';

class LocalTodoRepository {
  var databaseFuture = DatabaseHelper.db.database;

  Future<TodoList> fetchTodos() async {
    late final TodoList todoList;
    final Database database = await databaseFuture;
    final todoMap = await database.query(S.todoTableName);
    todoList = todoMap.map((e) => TodoList.fromJson(e)) as TodoList;
    return todoList;
  }

  // Future<void> updateLocalTodoDatatable(List<Todo> todoList) async {
  //   final Database database = await databaseFuture;
  //   Batch batch = database.batch();
  //   todoList.forEach((todo) async {
  //     batch.insert(
  //       S.todoTableName,
  //       todo.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   });
  //   batch.commit();
  // }
}