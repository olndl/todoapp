// import 'package:header/data/entity/todos_entity.dart';
// import 'package:header/domain/model/todo.dart';
// import 'package:uuid/uuid.dart';
//
 import 'package:uuid/uuid.dart';

import '../../domain/model/todo.dart';

class TodoMapper {
//   static Todo transformToModel(final TodoEntity entity) {
//     return Todo(
//       id: entity['id'],
//       createdAt: entity['created_at'],
//       title: entity['text'],
//       lastUpdatedBy: entity['last_updated_by'],
//       changedAt: entity['changed_at'],
//       dueDate: entity['deadline'],
//       color: entity['color'],
//       isCompleted: entity['done'] == 1,
//       importance: entity['importance'],
//     );
//   }
//
//   static TodoEntity transformToMap(final Todo model) {
//     return {
//       'id': model.id,
//       'created_at': model.createdAt,
//       'text': model.title,
//       'last_updated_by': model.lastUpdatedBy,
//       'changed_at': model.changedAt,
//       'deadline': model.dueDate,
//       'color': model.color,
//       'done': model.isCompleted ? 1 : 0,
//       'importance': model.importance,
//     };
//   }
//
  static Todo transformToNewTodoMap(
      final String title,
      final int? dueDate,
      // final String color,
      // final bool isCompleted,
      // final String importance
      ) {
    return Todo(
        id: Uuid().v4(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        title: title,
        lastUpdatedBy: "olndlDevice",
        changedAt: DateTime.now().millisecondsSinceEpoch,
        dueDate: dueDate,
        color: null,
        isCompleted: false,
        importance: 'low');
  }
}
