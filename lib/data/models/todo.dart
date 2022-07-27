class Todo {
  final int id;
  final String task;
  final String datetime;

  Todo(this.datetime, {required this.id, required this.task});

  String getTodoTitle() {
    if (task.length > 95) {
      return '${task.substring(0, 95)}...';
    } else {
      return task;
    }
  }

  String getFullTodo() {
    return task;
  }

  String getDate() {
    return datetime;
  }
}
