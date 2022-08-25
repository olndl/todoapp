import '../model/todo.dart';

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

  // int? transformToSyncAtParameter(Map<String, dynamic> entity) {
  //   return entity['sync_at'];
  // }

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
      //'sync_at': syncAt
    };
  }
}
