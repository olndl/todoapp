import 'package:sqflite/sqflite.dart';
import 'package:todoapp/core/errors/logger.dart';
import 'package:todoapp/domain/mapper/mapper.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';
import '../../../core/constants/strings.dart';
import '../todos_database.dart';
import 'database_helper.dart';

class LocalTodosDatabaseImpl implements TodosDatabase {
  var databaseFuture = DatabaseHelper.db.database;

  @override
  Future<TodoList> allTodos() async {
    final Database database = await databaseFuture;
    final todoMap = await database.query(S.databaseName);
    final List<Todo> todoList =
        List<Todo>.from(todoMap.map((todo) => Todo.fromJson(todo)));
    Map<String, dynamic> todoObject = {
      'revision': 1,
      'status': 'ok',
      'list': todoList
    };
    await database.close();
    return TodoList.fromJson(todoObject);
  }

  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    late final Todo todoEntity;
    await database.transaction(
      (txn) async {
        final id = await txn.insert(
          S.databaseName,
          TodoMapper().transformToMap(todo),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        final results = await txn.query(
          S.databaseName,
          where: '${DatabaseHelper.columnAutoId} = ?',
          whereArgs: [id],
        );
        todoEntity = TodoMapper().transformToModel(results.first);
      },
    );
    await database.close();
    return todoEntity;
  }

  @override
  Future<void> updateTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    final String id = todo.id;
    await database.update(
      S.databaseName,
      TodoMapper().transformToMap(todo),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    await database.close();
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    final Database database = await databaseFuture;
    await database.delete(
      S.databaseName,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    await database.close();
  }

  // Future<void> updateLocalTodoDatatable(List<Todo> todoList) async {
  //   final Database database = await databaseFuture;
  //   Batch batch = database.batch();
  //   for (var todo in todoList) {
  //     batch.insert(
  //       S.databaseName,
  //       TodoMapper().transformToMap(todo),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  //   await batch.commit();
  // }

  @override
  Future<Todo> getTodo(String id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }
}
