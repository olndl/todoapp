import 'dart:convert';

import '../../domain/model/todo.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) {
    if (json['runtimeType'] == 'TodoSegment') {
      return TodoSegment(todo: json['todo']);
    } else if (json['runtimeType'] == 'ViewSegment') {
      return ViewSegment(todo: json['todo']);
    } else {
      return HomeSegment();
    }
  }

  JsonMap toJson() => <String, dynamic>{'runtimeType': runtimeType.toString()};

  @override
  String toString() => jsonEncode(toJson());
}

typedef TypedPath = List<TypedSegment>;

class HomeSegment with TypedSegment {}

class TodoSegment with TypedSegment {
  TodoSegment({required this.todo});

  final Todo? todo;

  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo;
}

class ViewSegment with TypedSegment {
  ViewSegment({required this.todo});

  final Todo todo;

  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo;
}
