import 'package:todoapp/domain/model/todo_list.dart';

import '../model/todo.dart';

//отдельный маппер нужен для работы c sqflite

class TodoMapper {
  Todo transformToModel(Map<String, dynamic> entity) {
    return Todo(
      id: entity['id'],
      createdAt: entity['created_at'],
      text: entity['text'],
      lastUpdatedBy: entity['last_updated_by'],
      changedAt: entity['changed_at'],
      deadline: entity['deadline'],
      done: entity['done'] == 1,
      importance: entity['importance'],
    );
  }

  TodoList transformListToModel(Map<String, dynamic> entity) {
    return TodoList(
      revision: entity['revision'],
      status: entity['status'],
      list: entity['list'],
    );
  }

  Map<String, dynamic> transformListToMap(List<Todo> model) {
    return {'revision': 1, 'status': 'ok', 'list': model};
  }

  Map<String, dynamic> transformToMap(Todo model) {
    return {
      'id': model.id,
      'created_at': model.createdAt,
      'text': model.text,
      'last_updated_by': model.lastUpdatedBy,
      'changed_at': model.changedAt,
      'deadline': model.deadline,
      'color': model.color,
      'done': model.done ? 1 : 0,
      'importance': model.importance,
    };
  }
}
