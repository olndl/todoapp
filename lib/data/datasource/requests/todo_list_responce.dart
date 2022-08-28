import 'package:todoapp/domain/model/todo_list.dart';

import '../../../domain/model/todo.dart';

class TodoListResponce {
  final List<Todo> todoList;

  TodoListResponce(this.todoList);

  TodoList getResponce() => TodoList.fromJson(
        {'status': 'ok', 'revision': 1, 'list': todoList},
      );
}
