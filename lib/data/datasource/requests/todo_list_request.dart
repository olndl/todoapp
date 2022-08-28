import '../../../domain/model/todo.dart';

class TodoListRequest {
  final List<Todo> todoList;

  TodoListRequest(this.todoList);

  Map<String, Object> getRequest() => {'status': 'ok', 'list': todoList};
}
