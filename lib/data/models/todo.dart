class Todo {
  final int id;
  final int prio;
  final String task;
  final String? datetime;

  Todo({
    required this.datetime,
    required this.id,
    required this.task,
    this.prio = 0,
  });

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

  String? getDate() {
    return datetime;
  }
}
