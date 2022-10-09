import '../../domain/model/todo.dart';
import '../../domain/model/todo_list.dart';

abstract class TodosDatabase {
  Future<TodoList> allTodos();
  Future<TodoList> patchTodos(TodoList todoList, int revision);
  Future<Todo> insertTodo(Todo todo, int revision);
  Future<void> updateTodo(Todo todo, int revision);
  Future<void> deleteTodo(String id, int revision);
}
