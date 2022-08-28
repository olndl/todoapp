import '../../../domain/model/todo.dart';

class TodoRequest {
  final Todo todo;

  TodoRequest(this.todo);

  Map<String, Object> getRequest() =>
      {'status': 'ok', 'element': todo.toJson()};
}
