import 'package:uuid/uuid.dart';
import '../../domain/model/todo.dart';
import '../../domain/model/todo_list.dart';
import '../../domain/repository/todos_repository.dart';
import '../datasource/remote_database/todos_database.dart';


class TodosRepositoryImpl implements TodosRepository {
  final TodosDatabase database;

  const TodosRepositoryImpl(this.database);

  @override
  Future<TodoList> getTodoList() async {
    final todoList = await database.allTodos();
    return todoList;
  }

  @override
  Future<Todo> createTodo(
    final int revision,
    final String title,
    final int? dueDate,
    final String importance,
  ) async {
    final todo = Todo(
        id: Uuid().v4(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        text: title,
        lastUpdatedBy: "olndlDevice",
        changedAt:  DateTime.now().millisecondsSinceEpoch,
        deadline: dueDate,
        color: '0XFFFFFF',
        done: false,
        importance: importance,);
    await database.insertTodo(todo, revision);
    return todo;
  }

  @override
  Future<void> updateTodo(
    final int revision,
    final String id,
    final int createdAt,
    final String title,
    final String lastUpdatedBy,
    final int changedAt,
    final int? dueDate,
    final String color,
    final bool isCompleted,
    final String importance,
  ) async {
    final todo = Todo(
        id: id,
        createdAt: createdAt,
        text: title,
        lastUpdatedBy: lastUpdatedBy,
        changedAt: changedAt,
        deadline: dueDate,
        color: color,
        done: isCompleted,
        importance: importance,);
    await database.updateTodo(todo, revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async =>
      await database.deleteTodo(id, revision);
}