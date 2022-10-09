import 'dart:convert';

import '../../domain/model/todo.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) {
    if (json['path'] == 'EditTodoSegment') {
      return EditTodoSegment(todo: json['todo']);
    }
    if (json['path'] == 'ViewTodoSegment') {
      return ViewTodoSegment(todo: json['todo']);
    }
    if (json['path'] == 'CreateTodoSegment') {
      return CreateTodoSegment(todo: null);
    }
    if (json['path'] == 'ListTodoSegment') {
      return ListTodoSegment();
    }
    return ListTodoSegment();
  }

  JsonMap toJson() => <String, dynamic>{'path': runtimeType.toString()};

  @override
  String toString() => jsonEncode(toJson());
}

typedef TypedPath = List<TypedSegment>;

class ListTodoSegment with TypedSegment {}

class CreateTodoSegment with TypedSegment {
  CreateTodoSegment({required this.todo});

  final Todo? todo;
}

class EditTodoSegment with TypedSegment {
  EditTodoSegment({required this.todo});

  final Todo todo;

  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo.id;
}

class ViewTodoSegment with TypedSegment {
  ViewTodoSegment({required this.todo});

  final Todo todo;

  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo.id;
}
