
import 'package:uuid/uuid.dart';

import '../../domain/model/todo.dart';
import '../../domain/model/todo_list.dart';
import '../../domain/repository/todos_repository.dart';
import '../datasource/database/todos_database.dart';
import '../mapper/todo_mapper.dart';

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
    // final String color,
    // final bool isCompleted,
    // final String importance,
  ) async {
    final todo = await database.insertTodo(
        TodoMapper.transformToNewTodoMap(
            title, dueDate,
            // color,
            // isCompleted,
            // importance
        ), revision);
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
    final int dueDate,
    final String color,
    final bool isCompleted,
    final String importance,
  ) async {
    final todo = Todo(
        id: id,
        createdAt: createdAt,
        title: title,
        lastUpdatedBy: lastUpdatedBy,
        changedAt: changedAt,
        dueDate: dueDate,
        color: color,
        isCompleted: isCompleted,
        importance: importance);
    await database.updateTodo(todo, revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async =>
      await database.deleteTodo(id, revision);
}
