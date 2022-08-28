import 'dart:convert';

import 'package:todoapp/core/errors/logger.dart';

import '../../domain/model/todo.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) {
    logger.info('JSON: $json');
    if (json['path'] == 'EditTodoSegment') {
      logger.info('Зашли в EDit: ${EditTodoSegment(todo: json['todo'])}');
      return EditTodoSegment(todo: json['todo']);
    }
    if (json['path'] == 'ViewTodoSegment') {
      logger.info('Зашли в View: ${ViewTodoSegment(todo: json['todo'])}');
      return ViewTodoSegment(todo: json['todo']);
    }
    if (json['path'] == 'CreateTodoSegment') {
      logger.info('Зашли в Create: ${CreateTodoSegment(todo: null)}');
      return CreateTodoSegment(todo: null);
    }
    if (json['path'] == 'ListTodoSegment') {
      logger.info('Зашли в List: ${ListTodoSegment()}');
      return ListTodoSegment();
    }
    logger.info('Зашли в List по умолчанию: ${ListTodoSegment()}');
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
