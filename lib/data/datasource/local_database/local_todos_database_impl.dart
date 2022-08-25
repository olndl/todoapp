import 'package:sqflite/sqflite.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';
import '../todos_database.dart';
import 'database_helper.dart';

class LocalTodosDatabaseImpl implements TodosDatabase {
  static const _databaseName = 'todos_database';
  var databaseFuture = DatabaseHelper.db.database;

  @override
  Future<TodoList> allTodos() async {
    late final List<Todo> todoList;
    final Database database = await databaseFuture;
    final todoMap = await database.query(_databaseName);
    todoList = todoMap.map((todo) => Todo.fromJson(todo)).toList();
    var todoObject = {'status': 'ok', 'revision': 1, 'list': todoList};
    return TodoList.fromJson(todoObject);
  }

  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    late final Todo todoEntity;
    await database.transaction((txn) async {
      final id = await txn.insert(
        _databaseName,
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final results = await txn.query(_databaseName,
          where: '${DatabaseHelper.columnId} = ?', whereArgs: [id],);
      todoEntity = Todo.fromJson(results.first);
    });
    return todoEntity;
  }

  @override
  Future<void> updateTodo(Todo todo, int revision) async {
    final Database database = await databaseFuture;
    final String id = todo.id;
    await database.update(
      _databaseName,
      todo.toJson(),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    final Database database = await databaseFuture;
    await database.delete(
      _databaseName,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateLocalPokemonDatatable(List<Todo> todoList) async {
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    for (var todo in todoList) {
      batch.insert(
        _databaseName,
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<Todo> getTodo(String id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) {
    // TODO: implement patchTodos
    throw UnimplementedError();
  }
}
