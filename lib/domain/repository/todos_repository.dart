import '../model/todo.dart';
import '../model/todo_list.dart';

abstract class TodosRepository {
  Future<TodoList> getTodoList();
  Future<TodoList> patchTodoList(
    final int revision,
    final TodoList todoList,
  );
  Future<Todo> createTodo(
    final int revision,
    final String title,
    final int? dueDate,
    final String importance,
  );
  Future<void> updateTodo(
    final int revision,
    final String id,
    final int createdAt,
    final String title,
    final String lastUpdatedBy,
    final int changedAt,
    final int? dueDate,
    final String? color,
    final bool isCompleted,
    final String importance,
  );
  Future<void> deleteTodo(final String id, final int revision);
}
