import '../model/todo_list.dart';

abstract class PatchTodoListUseCase {
  Future<TodoList> execute(
    final int revision,
    final TodoList todoList,
  );
}
